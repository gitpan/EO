package EO::Hash;

use strict;
use warnings;
use EO::Array;
use EO::Collection;

our $VERSION = 0.90;
our @ISA = qw( EO::Collection );

sub init {
  my $self  = CORE::shift;
  my $elems = CORE::shift;
  if ($self->SUPER::init( @_ )) {
    $self->element( {} );
    return 1;
  }
  return 0;
}

sub new_with_hash {
  my $class = shift;
  my $hash;
  if (@_ > 1) {
    $hash = { @_ };
  } else {
    $hash = shift;
  }
  if (!$hash) {
    throw EO::Error::InvalidParameters text => 'no hash provided';
  }
  if (!ref($hash)) {
    throw EO::Error::InvalidParameters text => 'not a reference';
  }
  if (ref($hash) && ref($hash) ne 'HASH') {
    throw EO::Error::InvalidParameters text => 'not a hash reference';
  }
  my $self = $class->new();
  $self->element( $hash );
  return $self;
}

sub object_at_index {
  my $self = shift;
  my $key  = shift;
  if (!$key) {
    throw EO::Error::InvalidParameters text => 'no key specified for object_at_index';
  }
  if (@_) {
    $self->element->{ $key } = shift;
    return $self;
  }
  return $self->element->{ $key };
}

sub delete {
  my $self = shift;
  my $key  = shift;
  if (!$key) {
    throw EO::Error::InvalidParameters text => 'no key specified for delete';
  }
  delete $self->element->{ $key };
}

sub count {
  my $self = shift;
  $self->keys->count;
}

sub iterator {
  my $self = shift;
  my %iter = %{$self->element };
  return %iter;
}

sub keys {
  my $self = shift;
  my %hash = $self->iterator;
  if (!wantarray) {
    my $array = EO::Array->new()->push( keys %hash );
    return $array;
  } else {
    return keys %hash;
  }
}

sub values {
  my $self = shift;
  my %hash = $self->iterator;
  if (!wantarray) {
    my $array = EO::Array->new()->push( values %hash );
    return $array;
  } else {
    return values %hash;
  }
}

1;

__END__

=head1 NAME

EO::Hash - hash type collection

=head1 SYNOPSIS

  use EO::Hash;

  $hash = EO::Hash->new();
  $hash->object_at_index( 'foo', 'bar' );
  my $thing = $hash->object_at_index( 'foo' );
  $thing->delete( 'foo' );


  my $keys  = $hash->keys;
  my $vals  = $hash->values;

  my $count = $hash->count;

=head1 DESCRIPTION

EO::Hash is an OO wrapper around Perl's hash type.

=head1 INHERITANCE

EO::Hash inherits from EO::Collection.

=head1 CONSTRUCTOR

EO::Hash provides the following constructors beyond those that the parent
class provides:

=over 4

=item new_with_hash( HASHREF )

Prepares a EO::Hash object that has all the elements contained in HASHREF.

=back

=head1 METHODS

=over 4

=item object_at_index( KEY [, VALUE] )

Gets and sets key value pairs.  KEY should always be a string.  If provided
VALUE will be placed in the EO::Hash object at the key KEY.

=item delete( KEY )

Deletes a key/value pair, indexed by key, from the EO::Hash object.

=item count

Returns an integer representing the number of key/value pairs in the EO::Hash
object.

=item iterator

Returns a Perl hash.

=item keys

In scalar context returns an EO::Array object of keys in the EO::Hash.  In list
context it returns a Perl array of keys in the EO::Hash.

=item values

In scalar context returns an EO::Array object of values in the EO::Hash.  In list
context it returns a Perl array of values in the EO::Hash.

=back

=head1 SEE ALSO

EO::Collection, EO::Array

=head1 AUTHOR

James A. Duncan <jduncan@fotango.com>

=head1 COPYRIGHT

Copyright 2003 Fotango Ltd. All Rights Reserved.

This module is released under the same terms as Perl itself.

=cut

