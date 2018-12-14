package Upserve::Catalog::Reader;

use strict;
use warnings 'FATAL';

use base 'Class::Accessor';
Class::Accessor->mk_accessors(qw/ csv headers io report_title report_range /);

use Text::CSV;

sub new {
    my ($class, $file) = @_;

    die "No file given to reader!" if not $file;
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

    my $csv = Text::CSV->new;
    $self->csv($csv);

    my $io = $self->io;
    my $header_line = $io->getline;
    $csv->parse(lc $header_line);
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
