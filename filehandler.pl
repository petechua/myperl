#!/usr/bin/perl
use warnings;
use strict;

my $i=0;
my $mynum_lines=<>;

my $now = gmtime; # Get the current universal timestamp as a string
print $now;

# print "There are $mynum_lines lines.\n";
while (<>)
{
	chomp;
	print "This is line $i:$_ \n";
	$i++;
	
	if(/swiftserve/ && !/#/)
	{
		print "SwiftServe DA found!\n";
	}
	else
	{
		print "No DA found!\n";
	}
}
