#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::Exception;
use Test::More tests => 3;

use TestEnv;

my %test = ( class => 'Upserve::Catalog::Factory', );
subtest 'setup' => sub{
    plan tests => 4;

    use_ok($test{class}) or die;
    use_ok("Upserve::Catalog::Reader") or die;

    $test{data_dir} = TestEnv::test_data_directory_for_class('Upserve::Catalog');
    ok(-d $test{data_dir}, "data_dir exists");

    lives_ok(
        sub{ $test{reader} = Upserve::Catalog::Reader->new( $test{data_dir}->file('catalog.booze.csv') ); },
        'create reader',
    );

};

subtest 'errors' => sub{
    plan tests => 2;

    throws_ok(sub{ $test{class}->build_next(); }, qr/No reader given/, "fails w/o reader");
    throws_ok(sub{ $test{class}->build(); }, qr/No ref given/, "fails w/o ref");

};

subtest 'item' => sub{
    plan tests => 4;

    my $obj = $test{class}->build_next($test{reader});
    ok($obj, "got item");
    isa_ok($obj, "Upserve::Catalog::Item");
    ok($obj->catalog_number, "set catalog_number");
    is($obj->discount_percent, '', "set discount_percent");

};

done_testing();
