#!/usr/bin/env perl6

use v6;
use JSON::Fast;

my $ragged;

sub MAIN(Str $json_file, Bool :$stdout = False, Bool :$view = False, Bool :$ragged_right = False) {
    $ragged = $ragged_right;
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

sub header(Str $header) {
    say '  \parskip 32pt';
    say '';
    say '  {\fontsize{16pt}{24pt}\selectfont\textbf{\emph{\buline{\textcolor{blue}{'~$header~'}}}}}';
    say '  \parskip 6pt';
    say '  \nopagebreak';
}

sub header2(Str $header is copy) {
    $header ~~ s:g/\&/\\\&/;
    say '  {\fontsize{12pt}{14pt}\selectfont\textbf{'~$header~'}}';
}

sub header3(Str $header) {
    say '  {\fontsize{12pt}{14pt}\selectfont\emph{'~$header~'}}';
    say '';
}

sub head(Str $name) {
    say '\documentclass[11pt,a4paper,oneside]{article}';
    say '\usepackage[top=1in, bottom=1in, left=1in, right=1in]{geometry}';
    say '\marginparsep0pt\marginparwidth0pt\headheight58pt\textheight630pt\parindent0pt\parskip10pt';
    say '';
    say '\usepackage{layout}';
    say '\usepackage[utf8]{inputenc}';
    say '\usepackage{helvet}';
    say '\renewcommand{\familydefault}{\sfdefault}';
    say '\usepackage{color}';
    say '\definecolor{blue}{RGB}{0,20,137}';
    say '\usepackage{fancyhdr}';
    say '\pagestyle{fancy}';
    say '\renewcommand{\headrulewidth}{0pt}';
    say '\renewcommand{\footrulewidth}{0pt}';
    say '\usepackage{lastpage}';
    say '\usepackage{graphicx}';
    say '\usepackage[export]{adjustbox}';
    say '';
    say '\usepackage[normalem]{ulem}';
    say '\newcommand\buline{\bgroup\markoverwith {\textcolor{blue}{\rule[-1.7pt]{1pt}{0.7pt}}}\ULon}';
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
    say '\lhead{\includegraphics[valign=c,height=30pt]{logo.png}}';
    say '\chead{}';
    say '\rhead{{\fontsize{14pt}{14pt}\textbf{Konsultprofil — '~$name~'}}}';
    say '%';
    say '\lfoot{{\fontsize{8pt}{9pt}\selectfont{';
    say '      \emph{\textbf{\textcolor{blue}{Init AB}}\\\\';
    say '        Engelbrektsgatan 7, Box 5618\\\\';
    say '        114 86 Stockholm, Sweden\\\\';
    say '        Telefon: 08 - 407 01 00\\\\';
    say '        E-post: info@init.se\\\\';
    say '        Web: www.init.se\\\\}';
    say '}}}';
    say '\cfoot{{\fontsize{8pt}{9pt}\selectfont}}';
    say '\rfoot{{\raisebox{-45pt}{\fontsize{8pt}{9pt}\selectfont Sidan \thepage(\pageref{LastPage})}}}';
}

sub ingress($name, $summary, $image, $caption) {
    say '\begin{minipage}[t]{10cm}';
    &header($name);
    for @($summary) -> $text {
        say '';
        say '  \emph{'~$text~'}';
    }
    say '\end{minipage}';
    say '\hspace{0.5cm}';
    say '\begin{minipage}[t]{5.25cm}';
    say '\includegraphics[valign=t,width=5.25cm]{'~$image~'}';
    say '\raggedright' if $ragged;
    say '  \parskip 6pt';
    say '';
    for @($caption) -> $text {
        say $text;
    }    
    say '\end{minipage}';
    say '  \parskip 24pt';
    say '';
}

sub presentation($name, $presentation, $examples) {
    say '\begin{minipage}[t]{7.5cm}';
    say '  \parskip 6pt';
    say '  \raggedright' if $ragged;
    &header("Vem är $name?");
    for @($presentation) -> $text {
        say '';
        say "  $text";
    }
    say '\end{minipage}';
    say '\hspace{0.5cm}';
    say '\begin{minipage}[t]{8.25cm}';
    say '  \parskip 6pt';
    say '  \raggedright';
    &header("Exempel på");
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
    &header("$header");
    for @($block) -> $description {
        say '';
        say '\begin{minipage}[t]{5.5cm}';
        &header2($description<customer>);
        say '';
        print "  $description<from>" if $description<from>;
        print " – $description<to>" if defined $description<to>;
        say '';
        say '\end{minipage}';
        say '\hspace{0.5cm}';
        say '\begin{minipage}[t]{9.8cm}';
        say "  \\parskip 6pt";
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
        say "  \\parskip 24pt";
        say '';
    }
}

sub knowledge($header, $block) {
    &header("$header");
    for @($block) -> $group {
        say '';
        say '\begin{minipage}[t]{5.5cm}';
        &header2($group<header>);
        say '\end{minipage}';
        say '\hspace{0.5cm}';
        say '\begin{minipage}[t]{9.8cm}';
        my $description = $group<description>;
        if $description.WHAT === Array {
            say '  \vspace{-12pt}';
            say '  \begin{itemize}';
            for @($description) -> $item {
                $item ~~ s:g/\&/\\&/;
                say '    \item ' ~ $item;
            }
            say '  \end{itemize}';
            say '  \vspace{-12pt}';
        } else {
            "$description" ~~ s:g/\&/\\&/;
            say "  $description";
        }
        say '\end{minipage}';
        say '\parskip 18pt';
    }
}

sub employment($employment) {
    say '';
    &header("Anställningar");
    say '\vspace{-12pt}';
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
