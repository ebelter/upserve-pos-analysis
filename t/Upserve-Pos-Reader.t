#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Test::Exception;
use Test::More tests => 5;

use TestEnv;

my %test = ( class => 'Upserve::Pos::Reader', );
subtest 'setup' => sub{
    plan tests => 2;

    use_ok($test{class});

    $test{data_dir} = TestEnv::test_data_directory_for_class('Upserve::Pos');
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

    my $reader = $test{class}->new($file);
    ok($reader, "create reader");

    my $obj = $reader->next;
    ok($obj, "got $type");
    ok(!$reader->next, "reader is empty");

};

subtest 'void' => sub{
    plan tests => 4;

    my $type = "void";
    my $bn = $type.".csv";
    my $file = $test{data_dir}->file($bn);
    ok(-s $file, "$bn file exists");

    my $reader = $test{class}->new($file);
    ok($reader, "create reader");

    my $obj = $reader->next;
    ok($obj, "got $type");
    ok(!$reader->next, "reader is empty");

};

subtest 'product mix' => sub{
    plan tests => 6;

    my $type = "product mix";
    my $bn = $type.".csv";
    $bn =~ s/\s+/-/g;
    my $file = $test{data_dir}->file($bn);
    ok(-s $file, "$bn file exists");

    my $reader = $test{class}->new($file);
    ok($reader, "create reader");

    for my $obj_type (qw/ Category Item Modifier /) {
        my $obj = $reader->next;
        is($obj->{type}, $obj_type, "obj $obj_type");
    }
    ok(!$reader->next, "reader is empty");

};

done_testing();
