# CVRatio data

This subdirectory stores intermediate data files.  This README documents how the data files were derived from the scripts in the `src` subdirectory and the external data sources noted in the "Data sources" section of the project README.

The source data files are _not_ included in this directory for copyright reasons.  The project README has instructions where the source data files can be obtained.

## Step one: Copy source files

Create a subdirectory within this directory called `source`.  Copy the following data files from UPSID-PC into the directory:

- `CHARCOD.STR`
- `LANGS.STR`
- `SEGS.STR`

Also copy the following ISO-639-2 data file, which is separate from UPSID-PC:

- `ISO-639-2_utf-8.txt`

## Step two: Convert UPSID source files

Use the `denul.pl` script to generate plain-text versions of the UPSID data files.  (Do _not_ do this on the ISO-639-2 data file.)  When the current directory is the root of the project, the following invocations will generate the conversions:

    src/denul.pl < data/source/CHARCOD.STR > data/source/CHARCOD.txt
    src/denul.pl < data/source/LANGS.STR > data/source/LANGS.txt
    src/denul.pl < data/source/SEGS.STR > data/source/SEGS.txt

## Step three: Generate sound table

Use the `classify.pl` script to generate the `sounds.txt` data file.  The following invocation will generate the file:

    src/classify.pl < data/source/CHARCOD.txt > data/sounds.txt

The resultant `sounds.txt` is already given here in this subdirectory.

## Step four: Generate ISO-639-1 table

Use the `langlist.pl` script to generate the `iso-639-1.txt` data file.  The following invocation will generate the file:

    src/langlist.pl < data/source/ISO-639-2_utf-8.txt > data/iso-639-1.txt

The resultant `iso-639-1.txt` is already given here in this subdirectory.

## Step five: Generate language token table

Use the `langtoken.pl` script to generate the `lang-token.txt` data file.  The following invocation will generate the file:

    src/langtoken.pl < data/iso-639-1.txt > data/lang-token.txt

The resultant `lang-token.txt` is already given here in this subdirectory.

## Step six: Merge ISO-639-1 and UPSID languages

Perform an automatic merger of the language token list from ISO-639-1 and the language table from UPSID.  Use the following invocation (all on one line):

    src/langmerge.pl
      data/source/LANGS.txt
      data/lang-token.txt
      data/upsid-unmapped-langs.txt
      data/lang-token-unmapped.txt
      data/lang-map-raw.txt

The `upsid-unmapped-langs.txt` file stores the UPSID languages that could not be merged with the ISO-639-1 token list.

The `lang-token-unmapped.txt` file stores the ISO-639-1 language tokens from ISO-639-1 languages that could not be merged with the UPSID language list.

The `lang-map-raw.txt` file stores the mapping from decimal UPSID language codes to ISO-639-1 language codes, without any manual corrections yet.

All these three resultant files are already given here in this subdirectory.

## Step seven: Compile manual corrections

Manually go through the `upsid-unmapped-langs.txt` and `lang-token-unmapped.txt` data files, and look for any languages that were not automatically merged because their names are different.

For example, `upsid-unmapped-langs.txt` contains a language `MANDARIN` and `lang-token-unmapped.txt` contains a language `CHINESE`.  There will need to be a manual correction to link the UPSID language `MANDARIN` to the ISO-639-1 language `CHINESE`.

The following corrections were discovered by manually going through the two data files:

       UPSID    |    ISO-639-1
    ------------+-----------------
     FARSI      | Persian
     HINDI-URDU | Hindi or Urdu
     INUIT      | Inuktitut
     KHMER      | Central Khmer
     MANDARIN   | Chinese
     SAAMI      | Northern Sami

(For the `HINDI-URDU` entry, you can map it to either `Hindi` or `Urdu` without any difference in results.)

By replacing the UPSID language names with the decimal UPSID codes (from `LANGS.txt`), and the ISO-639-1 names with the two-letter language codes (from `iso-639-1.txt`), the following manual correction mappings result:

    2013 fa
    2016 hi
    6901 iu
    2306 km
    2500 zh
    2155 se

(The `2016 hi` line can be replaced with `2016 ur` with no change in results.)

## Step eight: Create edited language map

Copy `lang-map-raw.txt` to `lang-map-edited.txt`.  Then, insert the manual correction records compiled in the previous step.  You can just add these lines at the end of the file.

The resultant `lang-map-edited.txt` file is already given here in this subdirectory.

## Step nine: Tabulate results

You can now generate the full and subset data tables, using the following invocations:

    src/tabulate.pl
      all
      data/source/SEGS.txt
      data/sounds.txt
      data/source/LANGS.txt
      data/lang-map-edited.txt
      > results-full.txt
    
    src/tabulate.pl
      iso
      data/source/SEGS.txt
      data/sounds.txt
      data/source/LANGS.txt
      data/lang-map-edited.txt
      > results-subset.txt

(These are two commands, each should be entered on a single line.)

The resultant `results-full.txt` and `results-subset.txt` files are already given in the root project directory.
