# Handle CV:s as JSON

## Author
Jonas Linde <jonas@init.se>
http://jonas.init.se/

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

The `cvform.p6` script needs to go into a cgi-bin directory and the
`cvtemplate.html` and `cv.css` should go to the document root of the
same web server.

The script assumes that the web server provides an authenticated user
name in the REMOTE_USER environment variable.

## Copyright

The logo provided as `img/logo.png` is owned by Init AB. Replace it
with your own if you wish to use the scripts. The rest of this
repository is available under GPLv3 (see LICENSE).
