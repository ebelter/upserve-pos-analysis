#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::Exception;
use Test::More tests => 3;

use TestEnv;

my %test = ( class => 'UpservePos::Factory', );
subtest 'setup' => sub{
    plan tests => 2;

    use_ok($test{class});

    $test{data_dir} = TestEnv::test_data_directory;
    #$test{data_dir} = TestEnv::test_data_directory_for_class($test{class});
    ok(-d $test{data_dir}, "data_dir exists");

};

subtest 'errors' => sub{
    plan tests => 2;

    throws_ok(sub{ $test{class}->new(); }, qr/No file given/, "fails w/o file");
    throws_ok(sub{ $test{class}->new("/blah"); }, qr/File does not exist/, "fails w/ invalid file");

};

subtest 'comp' => sub{
    plan tests => 4;

    my $type = "comp";
    my $bn = $type.".csv";
    my $file = $test{data_dir}->file($bn);
    ok(-s $file, "$bn file exists");

    my $factory = $test{class}->new($file);
    ok($factory, "create factory");
    is($factory->type, $type, "correct type");

    my $obj = $factory->next;
    ok($obj, "got $type");

};

done_testing();
