#!/usr/bin/perl
#use strict;
use warnings;
use Net::Ping;

# Host can be either an IP or domain name
#my $host = "www.google.com";
#my $host = "172.16.1.2";
@host_array = qw(www.google.com 172.16.1.1);


#optionally specify a timeout in seconds (Defaults to 5 if not set)
my $timeout = 10;

# Create a new ping object
$p = Net::Ping->new("icmp");

# Optionally specify a port number (Defaults to echo port is not used)
$p->port_number("80");

foreach (@host_array)
{
	my $host = $_;

	# perform the ping
	if( $p->ping($host, $timeout) )
	{
        	print "Host ".$host." is alive\n";
	}
	else
	{
        	print "Warning: ".$host." appears to be down or icmp packets are blocked by their server\n";
	}
}

# close our ping handle
$p->close();
