package EO::Array;

use strict;
use warnings;
use EO::Collection;

our $VERSION = "0.91";
our @ISA = qw( EO::Collection );


sub init {
  my $self = CORE::shift;
  if ($self->SUPER::init( @_ )) {
    $self->element( [] );
    return 1;
  }
  return 0;
}

sub new_with_array {
  my $class = shift;
  my $array;
  if (@_ > 1) {
    $array = [ @_ ];
  } else {
    $array = shift;
  }
  if (!$array) {
    throw EO::Error::InvalidParameters text => 'no array specified';
  }
  if (!ref($array)) {
    throw EO::Error::InvalidParameters text => 'not a reference';
  }
  if (ref($array) && ref($array) ne 'ARRAY') {
    throw EO::Error::InvalidParameters text => 'not an array reference';
  }
  my $self = $class->new();
  $self->element( $array );
  return $self;
}

sub object_at_index {
  my $self = CORE::shift;
  my $idx  = CORE::shift;
  if (!defined($idx)) {
    throw EO::Error::InvalidParameters text => 'no index provided for the array';
  }
  if ($idx =~ /\D/) {
    throw EO::Error::InvalidParameters text => 'non-integer index specified';
  }
  if (@_) {
    $self->element->[ $idx ] = CORE::shift;
    return $self;
  }
  return $self->element->[ $idx ];
}

sub delete {
  my $self = CORE::shift;
  my $idx  = CORE::shift;
  if (!defined($idx)) {
    throw EO::Error::InvalidParameters text => "no index provided for the array";
  }
  if ($idx =~ /\D/) {
    throw EO::Error::InvalidParameters text => 'non-integer index specified';
  }
  $self->splice($idx,1);
}

sub splice {
  my $self = CORE::shift;
  my $offset = CORE::shift;
  my $length = CORE::shift;
  CORE::splice(@{ $self->element }, $offset, $length, @_);
}

sub count {
  my $self = CORE::shift;
  return scalar( $self->iterator );
}

sub push {
  my $self = CORE::shift;
  CORE::push @{ $self->element }, @_;
  return $self;
}

sub pop {
  my $self = CORE::shift;
  CORE::pop @{ $self->element };
}

sub shift {
  my $self = CORE::shift;
  CORE::shift @{ $self->element };
}

sub unshift {
  my $self = CORE::shift;
  CORE::unshift @{ $self->element }, @_;
  return $self;
}

sub join {
  my $self = CORE::shift;
  my $joiner = CORE::shift;
  return join($joiner, $self->iterator);
}

sub iterator {
  my $self = CORE::shift;
  my @list = @{ $self->element };
  return @list;
}

1;

__END__

=head1 NAME

EO::Array - array type collection

=head1 SYNOPSIS

  use EO::Array;

  $array = EO::Array->new();
  $array->object_at_index( 0, 'bar' );

  my $thing = $array->object_at_index( 0 );
  $thing->delete( 0 );

  $array->push('value');
  my $value = $array->shift( $array->unshift( $array->pop() ) );

  my $count = $array->count;

=head1 DESCRIPTION

EO::Array is an OO wrapper around Perl's array type.

=head1 INHERITANCE

EO::Array inherits from EO::Collection.

=head1 CONSTRUCTOR

EO::Array provides the following constructors beyond those that the parent
class provides:

=over 4

=item new_with_array( ARRAYREF )

Prepares a EO::Array object that has all the elements contained in ARRAYREF.

=back

=head1 METHODS

=over 4

=item object_at_index( KEY [, VALUE] )

Gets and sets key value pairs.  KEY should always be an integer.  If provided
VALUE will be placed in the EO::Array object at the index KEY.

=item delete( KEY )

Deletes a key/value pair, indexed by key, from the EO::Array object.

=item count

Returns an integer representing the number of key/value pairs in the EO::Array
object.

=item iterator

Returns a Perl array.

=item pop

Removes an item from the end of the EO::Array and returns it

=item push( LIST )

Adds items on to the end of the EO::Array object

=item shift

Removes an item from the beginning of the EO::Array

=item unshift( LIST )

Adds items on to the beginning of the EO::Array object

=item splice( [OFFSET [, LENGTH [, LIST]]] )

Splice an array (see perldoc -f splice for more information).

=back

=head1 SEE ALSO

EO::Collection, EO::Hash

=head1 AUTHOR

James A. Duncan <jduncan@fotango.com>

=head1 COPYRIGHT

Copyright 2003 Fotango Ltd. All Rights Reserved.

This module is released under the same terms as Perl itself.

=cut
