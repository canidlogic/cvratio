# CVRatio scripts

This directory contains Perl scripts used to process data files and tabulate results.  Along with each script, Markdown documentation is provided that is automatically generated from the POD documentation within the scripts.  See the Markdown documentation of the individual scripts for further information.

    denul.pl

The data files from UPSID are distributed in `.STR` files.  These files are like plain-text US-ASCII files, except they also include nul characters.  The `denul.pl` script replaces all nul characters in input with Unicode U+00B7, which is the interpunct character.  Running UPSID `.STR` files through this script converts them into UTF-8 plain-text files.

    classify.pl

Takes the UPSID `CHARCOD.STR` data file, after it has been run through `denul.pl`, and generates a data file with records that indicate for each UPSID phoneme whether the phoneme is a consonant or a vowel, the X-SAMPA code used for it in the UPSID data, and a descriptive name for the sound.

    langlist.pl

Takes the ISO 639-2 data file and generates a listing of ISO-639-1 language codes and the languages they map to.

    langtoken.pl

Takes the ISO-639-1 language code list generated by `langlist.pl` and creates a mapping from language "tokens" to ISO-639-1 language codes.  Languages may have multiple names, and language names may have qualifiers in the ISO-639-1 language list.  This script parses the language names and reduces them to individual identifying tokens that can be used to figure out from a language name which ISO-639-1 language code it corresponds to.

    langmerge.pl

Merges the UPSID `LANGS.STR` data file (after being run through `denul.pl`), and the language token list generated by `langtoken.pl`.  The result is a mapping from UPSID decimal language codes to ISO-639-1 two-letter language codes.  The script also generates a file of UPSID language names that couldn't be mapped to ISO-639-1 two-letter language codes, and a file of ISO-639-1 records that weren't mapped to any UPSID language names.  These two extra files can then be used to determine what manual corrections are required in the generated mapping files.

    tabulate.pl

Tabulates the statistics files.  You need the `SEGS.STR` and `LANGS.STR` data files, both after being run through `denul.pl`.  You also need the sound table generated by the `classify.pl` script.  Finally, you will need a language mapping table generated by `langmerge.pl` and then manually adjusted as necessary.  When the script is run in `all` mode, it generates a full table for all languages in UPSID.  When the script is run in `iso` mode, it only generates a subset of records for languages that are in the ISO-639-1 mapping.