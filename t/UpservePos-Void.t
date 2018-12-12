#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::More tests => 1;

use TestEnv;

my %test = ( class => 'UpservePos::Void', );
subtest 'tests' => sub{
    plan tests => 11;

    use_ok($test{class});

    my %p = (
		'check_owner' => 'Courtney Russell',
		'item' => 'Coors Light Can',
		'date' => '12/10/2017 2:23 pm',
		'check_number' => '1854',
		'authorized_by' => 'Courtney Russell',
		'note' => '',
		'amount' => '3.67',
		'reason' => 'Employee Shift Spend (Max $20 per shift)'
    );
	my $obj = $test{class}->new(\%p);
	isa_ok($obj, $test{class});

	is($obj->type, 'void', 'type');
    for ( keys %p ) {
        is($obj->$_, $p{$_}, $_);
    }

};

done_testing();
