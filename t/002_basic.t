
# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 15;
use Data::Dumper;
BEGIN { use_ok( 'EO::File' ); }

eval {
    my $file = EO::File->new(path => '/doesntexistanywhere/null');
    $file->load();
};
isa_ok($@, 'EO::Error::File');
isa_ok($@, 'EO::Error::File::NotFound');
like($@, qr/file not found/);

eval {
    my $file = EO::File->new(path => '/');
    $file->load();
};
isa_ok($@, 'EO::Error::File');
isa_ok($@, 'EO::Error::File::IsDirectory');
like($@, qr/path is a directory/);



open(FILE, "+>t/permission_denied");
close(FILE);
chmod(0000,'t/permission_denied');
die "Test couldnt run because file couldnt be created"
    unless(-e 't/permission_denied');

eval {
    my $file = EO::File->new(path => 't/permission_denied');
    $file->load();
};
isa_ok($@, 'EO::Error::File');
isa_ok($@, 'EO::Error::File::Permission');
isa_ok($@, 'EO::Error::File::Permission::Read');
like($@, qr/file not readable/);

my $file = EO::File->new->path('t/baz');

my $data = $file->load();
is($data->content,'FOOOOOBAAAAAR');
is(${$data->content_ref},'FOOOOOBAAAAAR');

$data->content('hi');
is($data->content,'hi');

undef $file;
undef $data;

my $path = Path::Class::File->new('t/test.txt');

$file = EO::File->new(path => $path);
$data = EO::Data->new()->content("content");

$data->storage($file);
$data->save();

{

    my $file2 = EO::File->new(path => $path);
    my $data2 = $file2->load();
    is($data2->content, "content");
}
$file->unlink();
undef($file);

__END__
EO::Data


EO::Data::Type::FileExtension
EO::Data::Type::Mime
EO::Data::ByteCount
EO::DateTime

EO::Storage
EO::File






