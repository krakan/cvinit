#!/home/jonas/git/rakudobrew/bin/perl6
use v6;
use HTML::Template;
use JSON::Fast;

# these are authorized to edit all files
my @admins = < jonas wallen joakim anders cmk peggy >;

sub MAIN(
    Bool :$show-json = False,
    Str :$gitdir = '/home/jonas/init/konsultprofil',
) {
    say "Content-Type: text/html\n";

    my $data = slurp if %*ENV<CONTENT_LENGTH>;
    say "<pre>";
    #for %*ENV.kv -> $k, $v {
    #    say "$k: $v";
    #}
    for <REQUEST_METHOD CONTENT_TYPE CONTENT_LENGTH QUERY_STRING REMOTE_USER> -> $key {
        say "$key: %*ENV{$key}" if %*ENV{$key};
    }

    my (%data, $group);
    if $data {
        my @data = $data.split('&');
        for @data -> $item {
            my ($key, $val) = $item.split("=");
            given $key {
                when "customer" {
                    $group = 'assignments';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                when "principal" {
                    $group = 'teaching';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                when "skill" {
                    $group = 'skills';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                when "education" {
                    $group = 'education';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                when "employer" {
                    $group = 'employment';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                when "education" {
                    $group = 'employment';
                    %data{$group} //= [];
                    push @(%data{$group}), {} if not %data{$group} or %data{$group}[0].keys;
                }
                default {
                    say "VFN: $key: $val";
                }
            }
            $val ~~ s:g[ '%' (<:hexdigit> ** 2) ] = chr :16(~$0);
            $val ~~ s:g/\+/ /;
            #$val = $val.convert('UTF-8');
            if $val {
                if $group {
                    %data{$group}[*-1]{$key} = $val;
                } else {
                    %data{$key} = $val;
                }
            }
        }
    }
    say to-json %data;
    say "</pre>";
  
    # figure out desired user name
    my $user = %*ENV<REMOTE_USER> // 'jonas';

    # read the json file
    my $json;
    my $file = "$gitdir/$user.json";
    if $file.IO ~~ :r {
        $json = from-json slurp $file;

        # provide git history
        my @git = ("git", "log", "--date=format:%F %R", "--pretty=%H %cd – %s", "$user.json");
        my $cwd = chdir $gitdir;
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

    # add alternative jsons if user is admin
    $json<browse> = so $user eq @admins.any;
    if ($json<browse>) {
        my @list;
        for dir(path => $gitdir, test => /'.json'$/) -> $file {
            my $data = from-json slurp $file;
            if $data<firstname> {
                my $name = "$data<firstname> $data<lastname>";
                push @list, {file => $file.basename, name => $name};
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
}

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
