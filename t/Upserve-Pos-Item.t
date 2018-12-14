#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::More tests => 1;

use TestEnv;

my %test = ( class => 'Upserve::Pos::Item' );
subtest "tests" => sub{
    plan tests => 19;

    use_ok($test{class});

    my %p = (
          'void' => '1',
          'sold' => '35',
          'cost' => '0',
          'gross' => '220.11',
          'price' => '5.85',
          'name' => 'Old Bakery Digital Native',
          'total_tax' => '15.44',
          'category_name' => 'Beer',
          'category_id' => '22dd2974-6673-493f-89fd-048b9508d28a',
          'gross_profit' => '138.3',
          'comps' => '66.37',
          'id' => '00c47440-9321-4210-beba-ecc7d542c590',
          'receipt_total' => '153.74',
          'comp' => '0',
          'identifier' => '',
          'net' => '138.3',
          'type' => 'item'
	);
    my $obj = $test{class}->new(\%p);
    ok($obj, 'obj new');

    for ( keys %p ) {
        is($obj->$_, $p{$_}, $_);
    }

};

done_testing();
