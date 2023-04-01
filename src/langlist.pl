#!/usr/bin/env perl
use strict;

=head1 NAME

langlist.pl - Compile ISO-639-1 list of languages.

=head1 SYNOPSIS

  classify.pl < ISO-639-2_utf-8.txt > languages.txt

=head1 DESCRIPTION

The input is the ISO 639-2 list in UTF-8 format from the Library of
Congress.  Only the two-letter ISO 639-1 records will be used.  The
output is a UTF-8 file where each line is a record having the two-letter
language code, a space, and then the name of the language.

See the project README "Data sources" section for where to obtain the
ISO 639-2 list.

=cut

# ==================
# Program entrypoint
# ==================

# Check no arguments
#
($#ARGV < 0) or die "Not expecting program arguments!\n";

# Set I/O modes
#
binmode(STDIN, ":encoding(utf8) :crlf") or
  die "Failed to set input I/O mode!\n";
binmode(STDOUT, ":encoding(utf8)") or
  die "Failed to set input I/O mode!\n";

# Start a hash that will map language codes to their names
#
my %ldict;

# Read input to fill the hash
#
my $lnum = 0;
for(
    my $ltext = readline(STDIN);
    defined $ltext;
    $ltext = readline(STDIN)) {
  
  # Update line number
  $lnum++;
  
  # Drop any line breaks
  chomp $ltext;
  
  # Whitespace trim
  $ltext =~ s/^\s+//;
  $ltext =~ s/\s+$//;
  
  # Skip if blank
  (length($ltext) > 0) or next;
  
  # Split into fields, and make sure exactly five fields
  my @fields = split /\|/, $ltext;
  (scalar(@fields) == 5) or
    die sprintf("Input line %d: Wrong number of fields!\n", $lnum);
  
  # Whitespace trim each field
  for my $f (@fields) {
    $f =~ s/^\s+//;
    $f =~ s/\s+$//;
  }
  
  # Get the two-letter code field and the English-language name field
  my $lang_code = $fields[2];
  my $lang_name = $fields[3];
  
  # Skip if no two-letter code
  (length($lang_code) > 0) or next;
  
  # Check that two-letter code is two letters and normalize to lowercase
  ($lang_code =~ /^[A-Za-z]{2}$/) or
    die sprintf("Input line %d: Invalid language code!\n", $lnum);
  $lang_code =~ tr/A-Z/a-z/;
  
  # Check that language name is not empty
  (length($lang_name) > 0) or
    die sprintf("Input line %d: Empty language name!\n", $lnum);
  
  # Make sure language code not already defined
  (not (defined $ldict{$lang_code})) or
    die sprintf("Language code %s defined multiple times!\n",
                $lang_code);
  
  # Add to mapping
  $ldict{$lang_code} = $lang_name;
}

# Print results
#
for my $k (sort keys %ldict) {
  printf "%s %s\n", $k, $ldict{$k};
}

=head1 AUTHOR

Noah Johnson, C<noah.johnson@loupmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2023 Multimedia Data Technology Inc.

MIT License:

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut
