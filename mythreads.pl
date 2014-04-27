#!/usr/bin/perl
use warnings;
use strict;
use thread;
use threads::shared;

my $i;
my @threads;
my $req_threads;
my $num_threads=2;
my $public_thread_count :shared = 0;
my $thread_complete;

system"clear";

for($i=0;$i<5;$i++) #This will loop though all the domains
{
	$thread_complete=0;
	while($thread_complete!=1)
	{
		while($public_thread_count<$num_threads)
		{	
			$req_threads=threads->new(\&fetch_url,$i);
			push(@threads,$req_threads);
			$thread_complete = 1;
		}
	}
}

foreach(@threads)
{
	$_->join();
}
sub fetch_url
{
	my $range=100;
	my $random_number = rand($range);
	my $id=$_[0];
	
	lock($public_thread_count+=1);
	print $public_thread_count."\n";
	print "Thread:$id starting...sleep time: $random_number\n";
        sleep $random_number;
	print "Thread:$id ended...\n";
	lock($public_thread_count-=1);
	print $public_thread_count."\n";

}
