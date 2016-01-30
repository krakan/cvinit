#!/usr/bin/env perl6

use v6;
use JSON::Fast;

my %fmt = (
    page => {
        left => 2.54,
        right => 2.54,
        top => 2.54,
        bottom => 2.86,
        skip => 6,
        gutter => 0.5,
    },
    font => {
        family => 'helvet',
        size => 11,
        blue => '0,20,137',
    },
    logo => {
        image => 'logo.png',
        height => 58,
        imgheight => 29, # half
    },
    header0 => {
        size => 14,
        bold => True,
        italic => False,
        underline => False,
        blue => False,
    },
    header1 => {
        size => 16,
        bold => True,
        italic => True,
        underline => True,
        blue => True,
        skip => 32,
    },
    header2 => {
        size => 12,
        bold => True,
        italic => False,
        underline => False,
        blue => False,
    },
    header3 => {
        size => 12,
        bold => False,
        italic => True,
        underline => False,
        blue => False,
    },
    footer0 => {
        size => 8,
        bold => True,
        italic => True,
        underline => False,
        blue => True,
    },
    footer => {
        size => 8,
        bold => False,
        italic => True,
        underline => False,
        blue => False,
    },
    ingress => {
        ragged => False,
        halfwidth => 10,
        skip => 24,
    },
    presentation => {
        ragged => False,
        halfwidth => 7.75,
    },
    assignments => {
        ragged => False,
        halfwidth => 5.5,
        skip => 18,
    },
    knowledge => {
        ragged => False,
        halfwidth => 5.5,
        skip => 24,
    },
    employment => {
        ragged => True,
    },
);

# LaTeX margins are weird - this seems to be approximately correct:
%fmt<page><width> = 21.0 - %fmt<page><left> - %fmt<page><right>;
%fmt<page><height> = 841.89 - (%fmt<page><top>+%fmt<page><bottom>)*28.35 - %fmt<logo><height>;
# A4 = 21.0 x 29.7
# 297 mm ≅ 841.89 pt
# 1 cm ≅ 28.35 pt
# 1 in = 72 pt

sub MAIN(Str $json_file, Bool :$stdout = False, Bool :$view = False, Bool :$ragged = False) {
    %fmt<ingress><ragged> =
    %fmt<presentation><ragged> =
    %fmt<assignments><ragged> =
    %fmt<knowledge><ragged> =
    True if $ragged;
    my $base = $json_file;
    $base ~~ s/\.json$//;
    my $texfile = "$base.tex";
    unless ($stdout) {
        my $TEX = open $texfile, :w;
        $*OUT = $TEX;
    }

    my $json = from-json slurp $json_file;

    head("$json<firstname> $json<lastname>");
    ingress("$json<firstname> $json<lastname>", $json<summary>, $json<image>, $json<caption>);
    presentation($json<firstname>, $json<presentation>, $json<examples>);
    assignments('Uppdrag', $json<assignments>);
    assignments('Utbildningsuppdrag', $json<teaching>);
    knowledge('Kunskaper', $json<skills>);
    knowledge('Utbildning', $json<education>);
    employment($json<employment>);
    foot();

    unless ($stdout) {
        run 'pdflatex', $texfile;
        run 'pdflatex', $texfile;
        unlink $texfile, "$base.aux", "$base.log";
        run 'evince', "$base.pdf" if $view;
    }
}

sub clean(Str $string is copy) {
     $string ~~ s:g/\\//;
     $string ~~ s:g/\&/\\\&/;
     $string;
}

sub fontify (Str $type, Str $string is copy) {
    $string = '\textcolor{blue}{'~$string~'}' if %fmt{$type}<blue>;
    if %fmt{$type}<underline> {
        if %fmt{$type}<blue> {
            $string = '\bluline{'~$string~'}'
        } else {
            $string = '\bline{'~$string~'}'
        }
    }
    $string = '\emph{'~$string~'}' if %fmt{$type}<italic>;
    $string = '\textbf{'~$string~'}' if %fmt{$type}<bold>;
    $string = '{\fontsize{'~%fmt{$type}<size>~'pt}{'~(%fmt{$type}<size>+1)~'pt}\selectfont '~$string~'}' if %fmt{$type}<size>;
}

sub header1(Str $header) {
    say '  \parskip '~%fmt<header1><skip>~'pt';
    say '';
    say '  '~fontify('header1', clean($header));
    say '  \parskip '~%fmt<page><skip>~'pt';
    say '  \nopagebreak';
}

sub header2(Str $header) {
    say '  '~fontify('header2', clean($header));

}

sub header3(Str $header) {
    say '  '~fontify('header3', clean($header));
    say '';
}

sub head(Str $name) {
    say '\documentclass['~%fmt<font><size>~'pt,a4paper,oneside]{article}';
    my $margins = '';
    for <top bottom left right> -> $side {
        $margins ~= "$side=%fmt<page>{$side}cm,";
    }
    say '\usepackage['~$margins~']{geometry}';
    say '\marginparsep0pt\marginparwidth0pt\headheight'~%fmt<logo><height>~'pt\textheight'~%fmt<page><height>~'pt\parindent0pt';
    say '';
    say '\usepackage{layout}';
    say '\usepackage[utf8]{inputenc}';
    say '\usepackage{'~%fmt<font><family>~'}';
    say '\renewcommand{\familydefault}{\sfdefault}';
    say '\usepackage{color}';
    say '\definecolor{blue}{RGB}{'~%fmt<font><blue>~'}';
    say '\usepackage{fancyhdr}';
    say '\pagestyle{fancy}';
    say '\renewcommand{\headrulewidth}{0pt}';
    say '\renewcommand{\footrulewidth}{0pt}';
    say '\usepackage{lastpage}';
    say '\usepackage{graphicx}';
    say '\usepackage[export]{adjustbox}';
    say '';
    say '\usepackage[normalem]{ulem}';
    say '\newcommand\bluline{\bgroup\markoverwith {\textcolor{blue}{\rule[-1.7pt]{1pt}{0.7pt}}}\ULon}';
    say '\newcommand\bline{\bgroup\markoverwith {\textcolor{black}{\rule[-1.7pt]{1pt}{0.7pt}}}\ULon}';
    say '';
    say '\let\olditemize\itemize';
    say '\renewcommand{\itemize}{';
    say '  \olditemize';
    say '  \setlength{\itemsep}{1pt}';
    say '  \setlength{\parskip}{0pt}';
    say '  \setlength{\parsep}{0pt}';
    say '}';
    say '';
    say '%\usepackage{showframe}';
    say '';
    say '\begin{document}';
    say '%';
    say '\lhead{\includegraphics[valign=c,height='~%fmt<logo><imgheight>~'pt]{'~%fmt<logo><image>~'}}';
    say '\chead{}';
    say '\rhead{'~fontify('header0',"Konsultprofil – $name")~'}';
    say '%';
    say '\lfoot{';
    say fontify('footer0','Init AB\\\\');
    say fontify('footer','Engelbrektsgatan 7, Box 5618\\\\');
    say fontify('footer','114 86 Stockholm, Sweden\\\\');
    say fontify('footer','Telefon: 08 - 407 01 00\\\\');
    say fontify('footer','E-post: info@init.se\\\\');
    say fontify('footer','Web: www.init.se\\\\');
    say '}';
    say '\cfoot{'~fontify('footer', '')~'}';
    say '\rfoot{\raisebox{-'~(5*(%fmt<footer><size>+1))~'pt}'~fontify('footer', 'Sidan \thepage(\pageref{LastPage})')~'}';
}

sub ingress($name, $summary, $image, $caption) {
    my $left = %fmt<ingress><halfwidth>;
    my $right = %fmt<page><width>-%fmt<page><gutter>-$left;
    say '\begin{minipage}[t]{'~$left~'cm}';
    &header1($name);
    say '  \raggedright' if %fmt<ingress><ragged>;
    for @($summary) -> $text {
        say '';
        say '  \emph{'~$text~'}';
    }
    say '\end{minipage}';
    say '\hspace{'~%fmt<page><gutter>~'cm}';
    say '\begin{minipage}[t]{'~$right~'cm}';
    say '\includegraphics[valign=t,width='~$right~'cm]{'~$image~'}';
    say '  \parskip '~%fmt<page><skip>~'pt';
    say '';
    for @($caption) -> $text {
        say $text;
    }    
    say '\end{minipage}';
    say '  \parskip '~%fmt<ingress><skip>~'pt';
    say '';
}

sub presentation($name, $presentation, $examples) {
    my $left = %fmt<presentation><halfwidth>;
    my $right = %fmt<page><width>-%fmt<page><gutter>-$left;
    say '\begin{minipage}[t]{'~$left~'cm}';
    say '  \parskip '~%fmt<page><skip>~'pt';
    say '  \raggedright' if %fmt<presentation><ragged>;
    &header1("Vem är $name?");
    for @($presentation) -> $text {
        say '';
        say "  $text";
    }
    say '\end{minipage}';
    say '\hspace{'~%fmt<page><gutter>~'cm}';
    say '\begin{minipage}[t]{'~$right~'cm}';
    say '  \parskip '~%fmt<page><skip>~'pt';
    say '  \raggedright';
    &header1("Exempel på");
    say '';
    for @($examples) -> $example {
        &header2($example<header>);
        say '  \vspace{-12pt}';
        say '  \begin{itemize}';
        for @($example<descriptions>) -> $text {
            say '    \item ' ~ $text;
        }
        say '  \end{itemize}';
        say '  \vspace{-12pt}';
    }
    say '\end{minipage}';
    say '';
}

sub assignments($header, $block) {
    my $left = %fmt<assignments><halfwidth>;
    my $right = %fmt<page><width>-%fmt<page><gutter>-$left;
    &header1("$header");
    for @($block) -> $description {
        say '';
        say '\begin{minipage}[t]{'~$left~'cm}';
        if $description<customer> {
            &header2($description<customer>);
        } else {
            &header2($description<principal>);
        }
        say '';
        print "  $description<from>" if $description<from>;
        print " – $description<to>" if defined $description<to>;
        say '';
        say '\end{minipage}';
        say '\hspace{'~%fmt<page><gutter>~'cm}';
        say '\begin{minipage}[t]{'~$right~'cm}';
        say '  \parskip '~%fmt<page><skip>~'pt';
        say '  \raggedright' if %fmt<assignments><ragged>;;
        &header3($description<title>) if $description<title>;
        for @($description<description>) -> $text is copy {
            if $text.WHAT === Array {
                say '  \vspace{-12pt}';
                say '  \begin{itemize}';
                for @($text) -> $item {
                    say '    \item ' ~ $item;
                }
                say '  \end{itemize}';
                say '  \vspace{-12pt}';
                } else {
                $text ~~ s:g/\&/\\&/;
                say "  $text";
            }
            say '';
        }
        say '\end{minipage}';
        say '\parskip '~%fmt<assignments><skip>~'pt';
        say '';
    }
}

sub knowledge($header, $block) {
    my $left = %fmt<knowledge><halfwidth>;
    my $right = %fmt<page><width>-%fmt<page><gutter>-$left;
    &header1("$header");
    for @($block) -> $group {
        say '';
        say '\begin{minipage}[t]{'~$left~'cm}';
        &header2($group<header>);
        say '\end{minipage}';
        say '\hspace{'~%fmt<page><gutter>~'cm}';
        say '\begin{minipage}[t]{'~$right~'cm}';
        say '  \raggedright' if %fmt<knowledge><ragged>;;
        if $group<descriptions> {
            my $descriptions = $group<descriptions>;
            say '  \vspace{-12pt}';
            say '  \begin{itemize}';
            for @($descriptions) -> $item {
                $item ~~ s:g/\&/\\&/;
                say '    \item ' ~ $item;
            }
            say '  \end{itemize}';
            say '  \vspace{-12pt}';
        } else {
            my $description = $group<description>;
            "$description" ~~ s:g/\&/\\&/;
            say "  $description";
        }
        say '\end{minipage}';
        say '\parskip '~%fmt<knowledge><skip>~'pt';
    }
}

sub employment($employment) {
    say '';
    &header1("Anställningar");
    say '\vspace{-12pt}';
    say '  \raggedright' if %fmt<employment><ragged>;;
    say '\begin{itemize}';
    for @($employment) -> $description {
        my $out = '  \item ';
        $out ~= $description<role> ~ ', ' if $description<role>;
        $out ~= $description<employer> ~ ', ' if $description<employer>;
        $out ~= $description<from> if $description<from>;
        $out ~= " – $description<to>" if defined $description<to>;
        $out ~~ s/\,\s$//;
        say $out;
    }
    say '\end{itemize}';
}

sub foot () {
    say '\end{document}';
}
