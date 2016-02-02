# Handle CV:s as JSON

## Author
[Jonas Linde](http://jonas.init.se/) <jonas@init.se>

## TL;DR

A few scripts to handle Curriculum Vitae's as JSON, editing the data
in a web form and converting it to PDF via LaTeX.

## Purpose

I wanted a project to learn Perl6 and also avoid editing my CV in
either OpenOffice or Google Docs.

## Why LaTeX

I considered a few different approaches to formatting JSON data into a
PDF-file. There is no clean way to convert HTML and CSS to PDF. There
is a patched version of webkit that is supposed to be able to do this
but I failed to get it to build. Another approach would be to load the
HTML in a browser and then print it but I judged that to be too
fragile. Finally the SILE typesetter would work but required me to
code page headers and footers in Lua.

So I concluded that LaTeX was the best alternative.

## Installation

Install somewhere on a web server and point your web servers cgi-bin
to the `cgi` directory and document root to the `html` directory.

The `cvform.p6` script assumes that the web server provides an
authenticated user name in the REMOTE_USER environment variable.

If you have an Init LDAP account you can access this at
http://jonas.init.se/cgi-bin/cvform.p6. If not, get in touch so we can
hire you and set up an LDAP account. ;)

## Copyright

The logo provided as `img/logo.png` is owned by
[Init AB](http://www.init.ab/). Replace it with your own if you wish
to use the scripts. The rest of this repository is available under
GPLv3 (see LICENSE).
