# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More no_plan => 1;

BEGIN { use_ok( 'EO::Hash' ); }

ok(my $object = EO::Hash->new());

isa_ok($object, 'EO::Hash');
isa_ok($object, 'EO::Collection');
isa_ok($object, 'EO');

can_ok($object,'keys');
ok(my $array = $object->keys);
isa_ok($array, 'EO::Array');
isa_ok($array, 'EO::Collection');
isa_ok($array, 'EO');
can_ok($object,'object_at_index');
ok($object->object_at_index('array', $array));
is($array, $object->object_at_index('array'));
can_ok($object, 'count');
is(
   $object->keys->count,
   $object->values->count,
   "equal number of keys and values"
  );
is($object->count, 1);
ok($object->object_at_index('whoo',$array));
is($object->count,2);
ok($object->delete( 'whoo' ));
is($object->count,1);
ok($object->delete('array'));
is($object->count,0);

eval {
  my $thing = EO::Hash->new_with_hash();
};
ok($@, "got an exception: $@");
isa_ok($@,'EO::Error');
isa_ok($@,'EO::Error::InvalidParameters');

eval {
  my $thing = EO::Hash->new_with_hash( { one => 'thing' } );
  $thing->delete();
};
ok($@, "got an exception: $@");
isa_ok($@,'EO::Error');
isa_ok($@,'EO::Error::InvalidParameters');

eval {
  my $thing = EO::Collection->new();
  $thing->count;
};
ok($@);
isa_ok($@,'EO::Error');
isa_ok($@,'EO::Error::Method');
isa_ok($@,'EO::Error::Method::Abstract');

