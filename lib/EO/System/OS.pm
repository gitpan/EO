package EO::System::OS;

use strict;
use warnings;

use EO::Singleton;
use base qw( EO::Singleton );
our $VERSION = "0.92";


sub osname {
  return $^O;
}


1;

