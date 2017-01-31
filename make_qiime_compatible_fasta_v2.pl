#!usr/bin/perl
#make_qiime_compatible_fasta.pl
# This script is based off my original v1, but I found out I don't actually need the barcode
# information in the header for Qiime compatibility.  This script removes that part.

# This script still would be much better if it took a qiime map file also and matched them.

use strict; use warnings;

my $useage = "useage:  make_inline_bc.pl <input_demultiplexed_file.fasta> <SampleID>";
#print "Script is for taking previously demultiplexed and primer trimmed files (i.e. from mothur) and making them look like fasta headers that came from split_libraries.py in qiime.\n";
#print "DO NOT USE on non-demultiplexed files!!!\n";
#print "Making qiime compatible fasta headers...\n";

die($useage) if @ARGV != 2;

my $input_file = $ARGV[0];
my $sampID = $ARGV[1];

open INPUT, "<$input_file";
open OUTPUT, ">$input_file.qiime";

my $counter = 1;

while (<INPUT>) {
	my $seqID= $_;
	my $sequence = <INPUT>;
	
	chomp $seqID; #Remove the /n for now
	#Get the seq ID without the leading >
	my $seqIDsplit = substr $seqID, 1; 
	#Print the new ID with sample ID included.
	print OUTPUT "\>"; print OUTPUT "$sampID"; print OUTPUT "_$counter\n"; 
	#Print the barcode part qiime wants (no error correcting here)
	print OUTPUT $sequence;
	$counter++;
	}
	
close INPUT; close OUTPUT;
