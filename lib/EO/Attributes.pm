package EO::Attributes;

use strict;
use warnings;

use Attribute::Handlers;

BEGIN {
  use attributes;
  no warnings 'redefine';
  sub attributes::_warn_reserved () { 0 }
}

our $VERSION = 0.90;

sub UNIVERSAL::private : ATTR(CODE) {
  my ($package, $symbol, $referent, $attr, $data) = @_;
  no strict 'refs';
  no warnings 'redefine';
  my $thing = *{$symbol};
  my $meth  = substr($thing, rindex($thing,':')+1);
  *{$symbol} = sub {
    my $self = shift;
    my $class = ref($self);
    my ($callpkg, $callfile, $callline) = caller();
    if ($package ne $callpkg) {
      my $text = "Can't private method \"$meth\" from package $package";
      throw EO::Error::Method::Private
	text => $text,
	  file => $callfile;
    }
    $referent->( $self, @_ );
  };
}

sub UNIVERSAL::abstract : ATTR(CODE) {
  my ($package, $symbol, $referent, $attr, $data) = @_;
  no strict 'refs';
  no warnings 'redefine';
  my $thing = *{$symbol};
  my $meth  = substr($thing, rindex($thing,':')+1);
  *{$symbol} = sub {
    my $self = shift;
    my $class = ref($self);
    my ($package, $filename, $line) = caller();
    my $text = "Can't call abstract method \"$meth\" on object of type \"$class\"";
    throw EO::Error::Method::Abstract
      text => $text,
      file => $filename;
  };
}

1;

__END__

=head1 NAME

EO::Attributes - attributes used by EO

=head1 SYNOPSIS

  use EO::Attributes;

  sub foo : private { }
  sub bar : abstract { }

=head1 DESCRIPTION

This module provides two attributes.  Namely, C<private> and C<abstract>.
Information about these two attributes can be found in the documentation for
EO.

=head1 AUTHOR

James A. Duncan <jduncan@fotango.com>

=head1 SEE ALSO

EO

=head1 COPYRIGHT

Copyright 2004 Fotango Ltd.  All Rights Reserved.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

=cut

