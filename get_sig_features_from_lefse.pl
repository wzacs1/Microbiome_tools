#!/usr/bin/perl
# get_sig_features_from_lefse.pl

# Silly little script to trim just the non-discriminatory or non-significant features from a Lefse results table,
# and add the original values so it is easy to replot them with different program.
# v1 - Just trim for significant, ignore choice of discriminatory or significant for now.  
#	- To do: parse input and add needed raw data.

use strict; use warnings;

my $useage = "useage:  get_sig_features_from_lefse.pl <input_lefseResultsFile.tsv> <output>";

die($useage) if @ARGV != 2;

my $input_lefse = $ARGV[0];
my $output_file = $ARGV[1];

open INPUTL, "<$input_lefse";
open OUTPUT, ">$output_file";

print OUTPUT "FeatureID\tLefseOut\tDiscriminatory_Class\tLDA_score(log10)\tp-value\n";

while (<INPUTL>) {
	my $inline = $_;
	chomp $inline;
	my @lefArray = split(/\t/, $inline);
	my $pval = $lefArray[4];
	if ($pval =~ m/\-/) {  # Note that b/c lefse only outputs significant p-value I've used this wonky match instead of less than 0.05 for example.
	next
	}
	else {
	print OUTPUT "$inline\n";
	}
}

close INPUTL; close OUTPUT;
