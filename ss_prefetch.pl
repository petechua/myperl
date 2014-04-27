#!/usr/bin/perl
use strict;
use warnings;
use Net::Ping;

# SwiftServe CDN - Presales tool to pre-fetch/populate all CDN Edges with the requested URL object.
# Requires 1) List of SwiftServe CDN Edges hostname 2)Input CDN URL through STDIN 3)sudo access
# Usage: sudo ss_prefetch.pl <CDN List> e.g sudo ./ss_prefetch.pl mylist
# 
# Author: Pete Chua
# Version: 1.0 Dec 2013

# Declare Variables
my $origin_url; # This is the user input CDN URL
my $htime; # Human readable time
my $utime; # UNIX time
my @cdn_edges;
my $num_cdn_edges;
my $edge_alive;
my @cdn_edge_alive;
my $cdn_domain;
my $new_cdn_url;

# Declare configurable variables
my $path_log_dir="/tmp/log";
my $timeout=10;

system("clear");
print "Creating pre-requsites...\n";
print "#"x25;
print "\n";
print "Enter CDN URL: ";
chomp($origin_url=<STDIN>);

# Start pre-requsites check for log files creation and CDN host check

$utime = time;
$htime = localtime;

&logging($utime,$path_log_dir);

open my $logfileHandle, ">>", "/tmp/log/$utime.log" or die "Can't open '/tmp/log/$utime.log'\n";
print $logfileHandle "Starting CDN pre-fetch at:$htime\n"."Logfile created at - $path_log_dir/$utime.log\n";
#close $logfileHandle; Close at end of program

# Start to pharse input cdn list
while (<>)
{
        chomp;
        #print "This is line $i:$_ \n";
        #$i++;
        
        if(/swiftserve/ && !/#/)
        {
                #print "SwiftServe DA found!\n";
		push(@cdn_edges,$_);
		$num_cdn_edges++;
        }
        else
        {
                #print "No DA found!\n";
        }
}

#print "@cdn_edges";
print $logfileHandle "There are $num_cdn_edges CDN Edges node detected in input list...";
print "There are $num_cdn_edges CDN Edge nodes detected in input list...\n";

# Starting host_check for alive CDN Edges
foreach (@cdn_edges)
{
	$edge_alive=&host_check($timeout,$_);
	if($edge_alive ne "down")
	{
		push(@cdn_edge_alive,$edge_alive);
	}	
}
#print "@cdn_edge_alive"."\n";
print "There are ".scalar @cdn_edge_alive." CDN Edge nodes detected alive...\n";
print $logfileHandle "There are ".scalar @cdn_edge_alive." CDN Edges node detected alive...\n";

# Starting initial request for input CDN URL
my $initial_req_res=`curl -s -w "%{http_code}\n" $origin_url -o /dev/null`;
if($initial_req_res==200)
{
	print "Initial request for CDN URL success!...\n"; 
}
else
{
	die("Initial request for CDN URL failed! Exiting program...\n"); 
}

# End pre-requsites check for log files creation and CDN host check

# Start to retreive origin CDN domain and create new URL
$cdn_domain = $origin_url;
$new_cdn_url = $origin_url;
my $cdn_edge = "da1.sg1.swiftserve.com";

#$input_url =~ s/http:\/\/(.*\.com).*/$cdn_edge/; # get what is between www. and .com
$cdn_domain =~ s/http:\/\/(.*\.com).*/$1/; # get what is between www. and .com
#$input_url =~ s/^https?:\/\/www\.([\da-zA-Z\.-]+\.(com|net))/$1/;

#print $cdn_domain."\n";

# Creating new CDN URL
#$new_cdn_url =~ s/$cdn_domain/$cdn_edge/;

#print $new_cdn_url."\n";

foreach (@cdn_edge_alive)
{
	&fetch_object($origin_url,$cdn_domain,$_);
}

print "\n\nLog files created: $path_log_dir/$utime.log\n";
#close $logfileHandle; Close at end of program


## Section for subroutines ##

# Creation of log directory and log files
sub logging
{
        my ($log_time,$log_path);
        $log_time=$_[0];
        $log_path=$_[1];
        #print $log_time;
        
        mkdir $log_path, 0755 or print "Cannot create log directory: $!\n";
        open my $fileHandle, ">>", "/tmp/log/$log_time.log" or die "Can't open '/tmp/$log_time.log'\n";
        print $fileHandle "remote_ip size_download speed_download http_code url\n";
        close $fileHandle;
}

sub host_check
{
	my ($sub_timeout,$sub_host);
	$sub_timeout=$_[0];
	$sub_host=$_[1];
	
	# Create a new ping object
	my $p = Net::Ping->new("icmp");

	# Optionally specify a port number (Defaults to echo port is not used)
	$p->port_number("80");

        # perform the ping
        if( $p->ping($sub_host, $sub_timeout) )
        {
        	#print "Host ".$sub_host." is alive\n";
		return $sub_host;
        }
        else
        {	
                #print "Warning: ".$sub_host." appears to be down or icmp packets are blocked by their server\n";
		return "down";
        }	

	# close our ping handle
	$p->close();
}

sub fetch_object
{
	my ($sub_origin_url,$sub_cdn_domain,$sub_edge_domain,$new_cdn_url);
	$sub_origin_url=$_[0];
	$sub_cdn_domain=$_[1];
	$sub_edge_domain=$_[2];
	$new_cdn_url=$sub_origin_url;

	print $sub_origin_url."\n";
	#print $sub_cdn_domain." ".$sub_edge_domain."\n";
	# Creating new CDN URL
	$new_cdn_url =~ s/$sub_cdn_domain/$sub_edge_domain/;
	print "The new CDN URL is: $new_cdn_url\n";	
	
	#curl -s -w "%{remote_ip} %{size_download} %{speed_download} %{http_code} %{url_effective}\n" -H 'Host: edge.swiftsg.swiftserve.com' http://da1.jp1.swiftserve.com/Pete/petelfd/8s.jpg -o /dev/null

	my $fetch_url=`curl -s -w "%{remote_ip} %{size_download} %{speed_download} %{http_code} %{url_effective}\n" -H 'Host: $sub_cdn_domain' $new_cdn_url -o /dev/null`;
	print $fetch_url;

	#open my $fileHandle, ">>", "/tmp/log/$now2.log" or die "Can't open '/tmp/$now2.log'\n";
	print $logfileHandle "$fetch_url";
	#close $fileHandle;
}
