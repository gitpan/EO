
package EO::Storage;
use strict;
use warnings;
use EO;
our $VERSION = "0.92";
our @ISA = qw(EO);

sub load : Abstract;
sub save : Abstract;

1;




