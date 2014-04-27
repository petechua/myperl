#!/usr/bin/perl
use strict;
use warnings;

my $input_url;
#chomp($input_url=<STDIN>);
#print $input_url;
#print $_;

#if (/\s(\[a-zA-Z]+),/) 
#if (/\s(^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$),/) 
#{
#	print "the word was $1\n";
#}

#my $facebook = "www.facebook.com/xxxxxxxxxxx";
#$input_url = "www.facebook.com/xxxxxxxxxxx";
my $origin_url = "http://edge.facebook.com/xxxxxxxxxxx";
my $cdn_domain = $origin_url;
my $new_cdn_url = $origin_url;
my $cdn_edge = "da1.sg1.swiftserve.com";


#$input_url =~ s/http:\/\/(.*\.com).*/$cdn_edge/; # get what is between www. and .com
$cdn_domain =~ s/http:\/\/(.*\.com).*/$1/; # get what is between www. and .com
#$input_url =~ s/^https?:\/\/www\.([\da-zA-Z\.-]+\.(com|net))/$1/;

print $cdn_domain."\n";

# Creating new CDN URL
$new_cdn_url =~ s/$cdn_domain/$cdn_edge/;

print $new_cdn_url."\n";
