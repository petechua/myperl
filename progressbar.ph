#!/usr/bin/perl -w

{
    # TGM 2004-10-05
    # Progress bar code

    package ProgressBar;
    use Class::Struct width => '$', portion => '$', max_val => '$';
    use List::Util qw( min );

    sub draw {
        local $| = 1;
        my ($self, $x, $max_val) = @_;
        $max_val ||= $self->max_val;
        my $old_portion = $self->portion || 0;
        my $new_portion = int( $self->width * $x / $max_val + 0.5 );
        print "\b" x ( 6 + $self->width
                       - min( $new_portion, $old_portion ) )
            if defined $self->portion;
        print "="  x ( $new_portion - $old_portion ),
              " "  x ( $self->width - $new_portion ),
              sprintf " %3d%% ", int( 100 * $x / $max_val + 0.5 );
        $self->portion( $new_portion );
    }

    1;
}

# DEMO

my $pb = ProgressBar->new( width => 40, max_val => 10 );

# show progress 0 to 100% and then back down to 0% again

do { $pb->draw( $_ )    ; sleep 1 } for 0 .. 10;
do { $pb->draw( 9 - $_ ); sleep 1 } for 0 ..  9;
print "\n";
