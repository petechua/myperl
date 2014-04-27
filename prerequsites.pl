#!/usr/bin/perl
use warnings;
use strict;

# Checking prerequsites for folder and file creation.
# Author: Pete Chua

my $now1 = gmtime;
my $now2 = time;
my $now3 = localtime;
#print $now1."\n";
#print $now2."\n";
#print $now3."\n";

&logging($now2);
my $fetch_url=`curl -s -w "%{remote_ip} %{size_download} %{speed_download} %{http_code} %{url_effective}\n" http://www.conversant.com.sg/index.html -o /dev/null`;
print $fetch_url;

open my $fileHandle, ">>", "/tmp/log/$now2.log" or die "Can't open '/tmp/$now2.log'\n";
print $fileHandle "$fetch_url\n";
close $fileHandle;

sub logging
{
	my $log_time;
	$log_time=$_[0];
	#print $log_time;
	
	mkdir '/tmp/log', 0755 or warn "Cannot make log directory: $!\n";
	open my $fileHandle, ">>", "/tmp/log/$log_time.log" or die "Can't open '/tmp/$log_time.log'\n";
	print $fileHandle "remote_ip size_download speed_download http_code url\n";
	close $fileHandle;
}
