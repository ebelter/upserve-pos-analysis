#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::More tests => 1;

use TestEnv;

my %test = ( class => 'UpservePos::Comp', );
subtest 'tests' => sub{
    plan tests => 12;

    use_ok($test{class});

    my %p = (
		'check_owner' => 'Jamie Tedford',
		'type' => 'Item',
		'item' => 'Cheezy Taters',
		'authorized_by' => 'Jamie Tedford',
		'note' => '',
		'check_number' => '1880',
		'reason' => 'Customer Changed Mind(100%)',
		'date' => '12/10/2017 7:50 pm',
		'amount' => '2.71'
	);
    my $obj = $test{class}->new(\%p);
    isa_ok($obj, $test{class});

    is($obj->type, 'comp', 'type');
    my %p2 = %p;
    $p2{product_type} = delete $p2{type};
    for ( keys %p2 ) {
        is($obj->$_, $p2{$_}, $_);
    }

};

done_testing();
