#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::Exception;
use Test::More tests => 3;

use TestEnv;

my %test = ( class => 'Upserve::Catalog::Reader', );
subtest 'setup' => sub{
    plan tests => 2;

    use_ok($test{class}) or die;

    $test{data_dir} = TestEnv::test_data_directory_for_class('Upserve::Catalog');
    ok(-d $test{data_dir}, "data_dir exists");

};

subtest 'errors' => sub{
    plan tests => 2;

    throws_ok(sub{ $test{class}->new(); }, qr/No file given/, "fails w/o file");
    throws_ok(sub{ $test{class}->new("/blah"); }, qr/File does not exist/, "fails w/ invalid file");

};

subtest 'item' => sub{
    plan tests => 3;

    my $file = $test{data_dir}->file('catalog.booze.csv');
    ok(-s $file, "catalog file exists");

    my $reader = $test{class}->new($file);
    ok($reader, "create reader");

    my $obj = $reader->next;
    ok($obj, "got object");

};

done_testing();
