#!/usr/bin/env perl6
# -*- p6 -*-

use v6;
use JSON::Fast;

my $ragged;

sub MAIN(Str $json_file, Bool :$stdout = False, Bool :$view = False, Bool :$ragged_right = False) {
    my $base = $json_file;
    $base ~~ s/\.json$//;
    my $texfile = "$base.tex";
    unless ($stdout) {
        my $TEX = open $texfile, :w;
        $*OUT = $TEX;
    }

    my $json = from-json slurp $json_file;
    $ragged = $ragged_right;
    &head("$json<firstname> $json<lastname>");
    &ingress($json);
    &presentation($json);
    &assignments($json, 'assignments', 'Uppdrag');
    &assignments($json, 'teaching', 'Utbildningsuppdrag');
    &knowledge($json, 'skills', 'Kunskaper');
    &knowledge($json, 'education', 'Utbildning');
    &employment($json);
    &foot();

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
    say q:to/NAME/,qq:to/CONT/,q:to/DONE/;
    \documentclass[11pt,a4paper,oneside]{article}
    \usepackage[top=1in, bottom=1in, left=1in, right=1in]{geometry}
    \marginparsep0pt\marginparwidth0pt\headheight58pt\textheight630pt\parindent0pt\parskip10pt
    
    \usepackage{layout}
    \usepackage[utf8]{inputenc}
    \usepackage{helvet}
    \renewcommand{\familydefault}{\sfdefault}
    \usepackage{color}
    \definecolor{blue}{RGB}{0,20,137}
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
    \usepackage{lastpage}
    \usepackage{graphicx}
    \usepackage[export]{adjustbox}

    \usepackage[normalem]{ulem}
    \newcommand\buline{\bgroup\markoverwith {\textcolor{blue}{\rule[-1.7pt]{1pt}{0.7pt}}}\ULon}

    \let\olditemize\itemize
    \renewcommand{\itemize}{
      \olditemize
      \setlength{\itemsep}{1pt}
      \setlength{\parskip}{0pt}
      \setlength{\parsep}{0pt}
    }
    
    %\usepackage{showframe}
    
    \begin{document}
    %
    \lhead{\includegraphics[valign=c,height=30pt]{logo.png}}
    \chead{}
    \rhead{{\fontsize{14pt}{14pt}\textbf{Konsultprofil — 
    NAME
    $name
    CONT
    }}}
    %
    \lfoot{{\fontsize{8pt}{9pt}\selectfont{
          \emph{\textbf{\textcolor{blue}{Init AB}}\\\\
            Engelbrektsgatan 7, Box 5618\\\\
            114 86 Stockholm, Sweden\\\\
            Telefon: 08 - 407 01 00\\\\
            E-post: info@init.se\\\\
            Web: www.init.se\\\\}
    }}}
    \cfoot{{\fontsize{8pt}{9pt}\selectfont}}
    \rfoot{{\raisebox{-45pt}{\fontsize{8pt}{9pt}\selectfont Sidan \thepage(\pageref{LastPage})}}}
    DONE

}

sub ingress($json) {
    say '\begin{minipage}[t]{10cm}';
    &header("$json<firstname> $json<lastname>");
    for @($json<summary>) -> $text {
        say '';
        say '  \emph{'~$text~'}';
    }
    say '\end{minipage}';
    say '\hspace{0.5cm}';
    say '\begin{minipage}[t]{5.25cm}';
    say '\includegraphics[valign=t,width=5.25cm]{'~$json<image>~'}';
    say '\raggedright' if $ragged;
    say '  \parskip 6pt';
    say '';
    for @($json<caption>) -> $text {
        say $text;
    }    
    say '\end{minipage}';
    say '  \parskip 24pt';
    say '';
}

sub presentation($json) {
    say '\begin{minipage}[t]{7.5cm}';
    say '  \parskip 6pt';
    say '  \raggedright' if $ragged;
    &header("Vem är $json<firstname>?");
    for @($json<presentation>) -> $text {
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
    for @($json<examples>) -> $example {
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

sub assignments($json, $block, $header) {
    &header("$header");
    for @($json{$block}) -> $description {
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

sub knowledge($json, $block, $header) {
    &header("$header");
    for @($json{$block}) -> $group {
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

sub employment($json) {
    say '';
    &header("Anställningar");
    say '\vspace{-12pt}';
    say '\begin{itemize}';
    for @($json<employment>) -> $description {
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
