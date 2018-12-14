#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::More tests => 1;

use TestEnv;

my %test = ( class => 'Upserve::Catalog::Item' );
subtest "tests" => sub{
    plan tests => 22;

    use_ok($test{class});

    my %p = (
		'canister' => 'Bottle',
		'final_price' => '12.75',
		'unit_quantity' => '33.814',
		'item' => '360 Cherry Bing Vodka',
		'deposit' => '0',
		'published' => '1',
		'minimum_order' => '',
		'unit_of_measurement' => 'oz',
		'discount_percent' => '',
		'units_in_package' => '1',
		'can_be_ordered' => '1',
		'catalog_number' => '939614',
		'weighable' => '0',
		'allow_return' => '1',
		'price' => '12.75',
		'barcode' => '85592138690',
		'category' => 'Flavored Vodka',
		'vendor' => 'glazers',
		'additional_tax' => '',
		'tax' => '9.679'
	);
	my $obj = $test{class}->new(\%p);
	ok($obj, 'obj new');

	for ( keys %p ) {
		is($obj->$_, $p{$_}, $_);
	}

};

done_testing();
