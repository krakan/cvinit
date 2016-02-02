#!/home/jonas/git/rakudobrew/bin/perl6
use v6;
use HTML::Template;
use JSON::Fast;

sub MAIN(
    Bool :$debug is copy = False,
    Bool :$show-json = False,
) {
    say "Content-Type: text/html\n";

    # read config file
    my $file = $?FILE;
    $file ~~ s| <-[/]>+ "/" <-[^/]>+ $ |etc/cv.json|;
    my %cf = from-json slurp $file;

    # handle supplied data
    my $loggedin = %*ENV<REMOTE_USER> // 'jonas';
    $debug ||= True if %*ENV<QUERY_STRING> and %*ENV<QUERY_STRING> ~~ /"debug"/;
    my %data; # hash to hold input data
    if %*ENV<REQUEST_METHOD> eq 'POST' {
        my $match = %*ENV<CONTENT_TYPE> ~~ / "boundary=" (.*) /;
        my $boundary = "--$match[0]";
        my $contentlength = %*ENV<CONTENT_LENGTH> + 0;
        %data = parse $contentlength, $boundary, %cf<gitdir>;
    }

    # figure out desired user name
    my $user = %data<uid> // $loggedin;

    # read the json file
    my $json;
    my $file = "%cf<gitdir>/$user.json";
    if $file.IO ~~ :r {
        $json = from-json slurp $file;

        # provide git history
        my @git = ("git", "log", "--date=format:%F %R", "--pretty=%H %cd – %s", "$user.json");
        my $cwd = chdir %cf<gitdir>;
        my $proc = run @git, :out;
        if $proc {
            my @list;
            for $proc.out.lines -> $line {
                $line ~~ /^(.*?) \s (.*)$/;
                push @list, {hash => ~$0, message => ~$1};
            }
            $json<history> = @list;
        }
        chdir $cwd;
    }

    # empty defaults
    $json<firstname> //= "";
    $json<lastname> //= "";
    $json<image> //= "";
    $json<caption> //= "";
    $json<summary> //= [];
    $json<presentation> //= [];
    $json<examples> //= [];
    $json<assignments> //= [];
    $json<teaching> //= [];
    $json<skills> //= [];
    $json<education> //= [];
    $json<employment> //= [];

    # provide current uid for reference
    $json<uid> = $user;
    $json<debug> = $debug;

    # add alternative jsons if user is admin
    $json<browse> = so $loggedin eq %cf<admins>.any;
    if ($json<browse>) {
        my @list = [
            {
                uid => $user,
                name => "$json<firstname> $json<lastname>",
            },
        ];
        for dir(path => %cf<gitdir>, test => /'.json'$/) -> $file {
            my $data = from-json slurp $file;
            if $data<firstname> {
                my $name = "$data<firstname> $data<lastname>";
                my $uid = $file.basename;
                $uid ~~ s/\.json$//;
                push @list, {uid => $uid, name => $name} unless $uid eq $user;
            }
        }
        $json<name_list> = @list;
    }

    # tweak the data to fit the template
    for <examples education> -> $key {
        for @($json{$key}) -> $item {
            for @($item<descriptions>) <-> $desc {
                $desc = {text => $desc};
            }
        }
    }
    for <assignments teaching> -> $key {
        for @($json{$key}) -> $item {
            $item<description> = flatten $item<description>;
        }
    }
    for <caption presentation summary> -> $key {
        $json{$key} = flatten $json{$key};

    }

    # debug if requested
    if $show-json {
        say to-json($json);
        exit;
    }

    # apply the template
    my $template = HTML::Template.from_file('cvtemplate.html');
    $template.with_params(%$json);
    print $template.output;

    # debug output
    if $debug {
        say "<pre><font size='-2' color='#888'>";
        for <REQUEST_METHOD CONTENT_TYPE CONTENT_LENGTH QUERY_STRING REMOTE_USER> -> $key {
            say "$key: %*ENV{$key}" if %*ENV{$key};
        }
        say "<hr>";
        say to-json %data;
        say "<hr>";
        for %*ENV.kv -> $key, $val {
            say "$key: $val";
        }
        say "<hr>";
        say qx"ls -lat /usr/lib/cgi-bin";
        say "<hr>";
        say "</pre>";
    }
}

# parse the request data
sub parse (Int $contentlength, Str $boundary, Str $gitdir) {
    return {} unless $contentlength;

    my $buf = $*IN.read($contentlength);
    my $data = $buf.decode('ISO-8859-1');
    my (%data, %seen);
    return {} unless $data;

    my @data = $data.split($boundary);
    for @data -> $item is copy {
        next unless $item;
        next if $item ~~ /^"--"\s*$/;
        $item ~~ s/^\n//;

        # header
        my $disp = $item ~~ s/^"Content-Disposition: " <-[\n]>*?\n//;
        my $filename = $disp ~~ /'filename="' (<-[\n]>+?) '"'/;
        my $name = $disp ~~ /'name="' (<-[\n]>+?) '"'/;

        # chunk content
        $item ~~ s/\n$//;;
        if $filename {
            # handle uploaded file
            $item ~~ s/^"Content-Type: " <-[\n]>*\n\n//;
            my $img = open "$gitdir/$filename[0]", :w, :bin;
            # undecode binary data
            $img.write($item.encode('ISO-8859-1'));
            $img.close;
            $item = "$filename[0]";
        } else {
            # remove header separator
            $item ~~ s/^\n//;
        }
        my ($key, $val) = ($name[0], $item);

        # fix string encoding
        $val = $val.encode('ISO-8859-1').decode;
        if $val and $key ~~ /presentation|summary|assignments.description|teaching.description/ {
            $val = inflate $val;
        }
        given $key {
            when /^(.+)\.(.+)\.$/ {
                my $group = $0;
                my $subkey = $1;
                if $val {
                    %data{$group}[*-1]{$subkey} //= [];
                    push @(%data{$group}[*-1]{$subkey}), $val;
                }
            }
            when /^(.+)\.(.+)$/ {
                my $group = $0;
                my $subkey = $1;
                %data{$group} //= [{},];
                if (%seen{$key}) {
                    push @(%data{$group}), {} if %data{$group}[*-1].values;
                    %seen = ();
                }
                %data{$group}[*-1]{$subkey} = $val if $val;
            }
            default {
                %data{$key} = $val;
            }
        }
        %seen{$key}++;
    }
    %data;
}
 
# flatten array of strings for form output
sub flatten ($ref) {
    my @return;
    for @$ref -> $value {
        if $value.WHAT === Array {
            my @list;
            for @$value -> $item {
                push @list, " * $item";
            }
            push @return, join "\n", @list;
        } else {
            push @return, $value;
        }
    }

    join "\n\n", @return;
}

# build array of strings from form input
sub inflate ($str) {
    my @return = split /\n\n/, $str;
    for @return -> $item is rw {
        if $item ~~ /\n/ {
            $item ~~ s:g/^^\s\*\s//;
            $item = split /\n/, $item;
        }
    }
    return @return;
}
