#!/usr/bin/perl -w
#
# Progress Bar: Dots - Simple example of an LWP progress bar.
# http://disobey.com/d/code/ or contact morbus@disobey.com.
#
# This code is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#

use strict; $|++;
my $VERSION = "1.0";

# make sure we have the modules we need, else die peacefully.
eval("use LWP 5.6.9;");  die "[err] LWP 5.6.9 or greater required.\n" if $@;

# now, check for passed URLs for downloading.
die "[err] No URLs were passed for processing.\n" unless @ARGV;

# our downloaded data.
my $final_data = undef;

# loop through each URL.
foreach my $url (@ARGV) {
   print "Downloading URL at ", substr($url, 0, 40), "... ";

   # create a new useragent and download the actual URL.
   # all the data gets thrown into $final_data, which
   # the callback subroutine appends to.
   my $ua = LWP::UserAgent->new(  );
   my $response = $ua->get($url, ':content_cb' => \&callback, );
   print "\n"; # after the final dot from downloading.
}

# per chunk.
sub callback {
   my ($data, $response, $protocol) = @_;
   $final_data .= $data;
   print ".";
}
