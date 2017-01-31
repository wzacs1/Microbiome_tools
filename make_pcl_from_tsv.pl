#!/usr/bin/perl
# make_pcl_from_tsv.pl

use strict; use warnings;

my $useage = "useage:  make_pcl_from_tsv.pl <input> <output> <ClassName> <comma separated string of class to add>";

die($useage) if @ARGV != 4;

my $input_file = $ARGV[0];
my $output_file = $ARGV[1];
my $ClassName = $ARGV[2];
my $classes = $ARGV[3];

open INPUT, "<$input_file";
open OUTPUT, ">$output_file";

my @Cats = split(/,/, $classes);
my $ClassHeader = join("\t", @Cats);

my $header = <INPUT>; # Grab first header line which will become second.
chomp $header;
my @IDs = split(/\t/, $header);
shift @IDs;
my $NewHeader = join("\t", @IDs);

print OUTPUT "$ClassName\t$ClassHeader\n";
print OUTPUT "ID\t$NewHeader\n";

while (<INPUT>) {
	my $inline = $_;
	print OUTPUT "$inline";
}

close INPUT; close OUTPUT;
