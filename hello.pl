#!/usr/bin/perl
use warnings;
#use strict;

#Variables
$love1="Yun";
$love2="Jolene";


#Working Code
print "Hello World!\n";
print "I love ".$love1." & ".$love2."\n";;
print "I love $love1 & $love2.\n";

# Getting some input from standard input
chomp($input=<STDIN>);
print "Your previous input is :".$input."\n"; #Printing the previous input

# Getting lists of inputs and store in array
chomp(@input_array=<STDIN>);
foreach(@input_array)
{
	print $_;
}
#Starting loops

$i=5;
while($i>=0)
{
	print "$i\n";
	$i--;
}

#Arrays and lists

@my_array=qw(jolene yun quickie);

print "Simple just print array - @my_array\n";
$num_array=@my_array;
print "The number of array is :$num_array\n";
print "Printing the same array again.\n";
#print @my_array;

$i=0;
foreach(@my_array)
{
	print "Array $i: is @my_array[$i]\n";
	print "Array $i: is $_\n";
	$i++;
}

# Subroutines

&mysub(28,30);

sub mysub{
	$n+=1;
	print $n."\n";
	
	my($a,$b);
	($a,$b)=@_;
	print "Input A: $a\n"; 
	print "Input B: $b\n"; 
}

# Subroutines - Assign array into sub

&mysub2(@my_array);

sub mysub2
{
	my(@pri_array)=@_;
	print "This is the previous input array assign into sub:@pri_array\n";
}
