
package EO::Storage;
use strict;
use warnings;
use EO;
our $VERSION = 0.90;
our @ISA = qw(EO);

sub load : abstract;
sub save : abstract;

1;




