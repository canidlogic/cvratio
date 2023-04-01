#!/usr/bin/env perl
use strict;

=head1 NAME

classify.pl - Classify all sounds in the CHARCOD table into either vowel
or consonant categories.

=head1 SYNOPSIS

  classify.pl < CHARCOD.txt > output.txt

=head1 DESCRIPTION

The input must be the CHARCOD table from UPSID, after it has been run
through the C<denul.pl> script.

The output is a report that lists all sounds with their vowel or
consonant class, the code name, and the full name of the sound, sorted
first by class, then by the code name.

=cut

# =========
# Constants
# =========

# Maps exceptional sound codes to a vowel (0) or consonant (1) class.
#
my %EXCEPTIONS = (
  'iF' => 0,
  'uF' => 0,
  'uuF' => 0
);

# Maps all the vowel-like tokens to a value of 1
#
my %VOWEL_KEYS = (
  'vowel' => 1,
  'diphthong' => 1
);

# Maps all the consonant-like tokens to a value of 1
#
my %CONS_KEYS = (
  'approximant' => 1,
  'plosive' => 1,
  'implosive' => 1,
  'stop' => 1,
  'click' => 1,
  'fricative' => 1,
  'affricate' => 1,
  'tap' => 1,
  'flap' => 1,
  'trill' => 1,
  'nasal' => 1,
  'sibilant' => 1,
  'h' => 1,
  'r' => 1
);

# ===============
# Local functions
# ===============

# Comparison function for sorting the output records.
#
# This sorts first by vowel/consonant class, and then by the sound code.
#
sub rec_cmp {
  if ($a->[0] < $b->[0]) {
    return -1;
  
  } elsif ($a->[0] > $b->[0]) {
    return 1;
    
  } else {
    return ($a->[1] cmp $b->[1]);
  }
}

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

# Start a hash that will map sound codes to their textual description
#
my %sdict;

# Read input to fill the hash
#
my $lnum = 0;
while (1) {
  
  # Read up to two non-blank lines
  my @lines;
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
    
    # Add to array
    push @lines, $ltext;
    
    # If array has two lines, then leave this loop
    if (scalar(@lines) >= 2) {
      last;
    }
  }
  
  # If we didn't read any non-blank lines, we are done
  if (scalar(@lines) < 1) {
    last;
  }
  
  # If we got here, we should have two lines in the buffer
  (scalar(@lines) == 2) or 
    die "Unpaired record lines at end of file!\n";
  
  # Extract the sound code from the first line
  ($lines[0] =~ /^([\x{21}-\x{7e}]+)\x{b7}/) or
    die sprintf("Record ending at line %d: Can't parse sound code!\n",
          $lnum);
  my $sound_code = $1;
  
  # Extract the sound name from the second line
  ($lines[1] =~ /^([\x{20}-\x{7e}]+)\x{b7}/) or
    die sprintf("Record ending at line %d: Can't parse sound name!\n",
          $lnum);
  my $sound_name = $1;
  
  # Make sure sound code not already defined
  (not (defined $sdict{$sound_code})) or
    die sprintf("Sound code %s defined multiple times!\n", $sound_code);
  
  # Add to mapping
  $sdict{$sound_code} = $sound_name;
}

# Define an array of output records
#
my @recs;

# Fill in the records with a classifier 0 for vowel, 1 for consonant,
# the sound code, and the sound name
#
while(my ($k, $v) = each %sdict) {
  
  # Parse name into list of tokens
  my @tokens = split /[^A-Za-z]+/, $v;
  
  # Check for vowel and consonant keys
  my $vowel = 0;
  my $cons = 0;
  
  for my $tk (@tokens) {
    $tk =~ tr/A-Z/a-z/;
    
    if (defined $VOWEL_KEYS{$tk}) {
      $vowel = 1;
    }
    if (defined $CONS_KEYS{$tk}) {
      $cons = 1;
    }
  }
  
  # Determine classification
  my $cid;
  if (defined $EXCEPTIONS{$k}) {
    $cid = $EXCEPTIONS{$k};
  
  } elsif ($vowel and $cons) {
    die sprintf("Sound code %s is both vowel and consonant!\n", $k);
    
  } elsif ($vowel) {
    $cid = 0;
  
  } elsif ($cons) {
    $cid = 1;
    
  } else {
    die sprintf("Sound code %s is neither vowel nor consonant!\n", $k);
  }
  
  # Add record
  push @recs, ([$cid, $k, $v]);
}

# Sort records
#
my @results = sort rec_cmp @recs;

# Print each record
#
for my $r (@results) {
  my $ctype;
  if ($r->[0] == 0) {
    $ctype = 'v';
  } elsif ($r->[0] == 1) {
    $ctype = 'c';
  } else {
    die;
  }
  
  printf "%s %s %s\n", $ctype, $r->[1], $r->[2];
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
