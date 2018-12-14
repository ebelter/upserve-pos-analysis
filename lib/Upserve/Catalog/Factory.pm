package Upserve::Catalog::Factory;

use strict;
use warnings 'FATAL';

use Upserve::Catalog::Item;

sub build_next {
    my ($class, $reader) = @_;
    die "No reader given to get next object to build!" if not $reader;
    my $ref = $reader->next;
    return if not $ref;
    $class->build($ref);
}

sub build {
    my ($class, $ref) = @_;
    die "No ref given to build!" if not $ref;

    $ref->{catalog_number} = delete $ref->{'ctg_no.'};
    $ref->{discount_percent} = delete $ref->{'discount_(%)'};

    Upserve::Catalog::Item->new($ref);

}

1;
