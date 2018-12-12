#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::More tests => 1;

use TestEnv;

my %test = ( class => 'UpservePos::Modifier' );
subtest "tests" => sub{
    plan tests => 2;

    use_ok($test{class});
    is($test{class}->type, 'modifier', 'type is modifier');

};

done_testing();
