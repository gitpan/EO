# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More no_plan => 1;

BEGIN { use_ok( 'EO::Array' ); }

ok(my $object = EO::Array->new());

isa_ok($object, 'EO::Array');
isa_ok($object, 'EO');
isa_ok($object->element, 'ARRAY');
can_ok($object,'push');
can_ok($object, 'pop');
can_ok($object,'shift');
can_ok($object,'unshift');
can_ok($object,'object_at_index');
can_ok($object,'count');
can_ok($object,'iterator');
can_ok($object,'splice');
can_ok($object,'delete');

ok(my $test   = EO->new());

ok( $object->push( $test ) );
is( $object->pop, $test );
ok( $object->unshift( $test ) );
is( $object->shift, $test );
ok( $object->push( $test ),"push test" );
is( $object->object_at_index( 0 ), $test,"wooo" );
is( $object->count, 1 );
is( $object->iterator, 1 );
ok( $object->delete( 0 ) );
is( $object->count, 0 );

eval {
  my $thing = EO::Array->new_with_array();
};
ok($@);
isa_ok($@,'EO::Error');
isa_ok($@,'EO::Error::InvalidParameters');

eval {
  my $thing = EO::Array->new_with_array(['one']);
  $thing->delete();
};
ok($@);
isa_ok($@,'EO::Error');
isa_ok($@,'EO::Error::InvalidParameters');
