package UpservePos::Reader;

use strict;
use warnings 'FATAL';

use base 'Class::Accessor';
Class::Accessor->mk_accessors(qw/ csv headers io report_title report_range /);

use List::MoreUtils;
use List::Util;
use Text::CSV;

sub new {
    my ($class, $file) = @_;

    die "No file given to build factory!" if not $file;
    die "File does not exist: $file" if not -s $file;

    my $io = IO::File->new($file, 'r');
    die "Failed to open $file because $!" if not $io;

    my %params = ( io => $io, );
    my $self = bless \%params, $class;

    $self->_parse_header;

    $self;
}

sub _parse_header {
    my ($self) = @_;

    my $io = $self->io;
    my $report_title = $io->getline;
    chomp $report_title;
    $self->report_title($report_title);

    my $report_range = $io->getline;
    chomp $report_range;
    $self->report_range($report_range);

    my $header_line;
    do {
        $header_line = $io->getline;
    } until List::MoreUtils::any { $header_line =~ /^$_/ } (qw/ Date Type /);

    my $csv = Text::CSV->new;
    $self->csv($csv);
    $csv->parse(lc $header_line);# or die "Failed to parse line: $header_line";
    my @headers = map { my $h = $_; $h =~ s/\s+/_/g; $h } $csv->fields;
    $csv->column_names(@headers);

}

sub next {
    my ($self) = @_;
    my $ref = $self->csv->getline_hr( $self->io );
    return if not $ref;
    $ref;
}

1;
