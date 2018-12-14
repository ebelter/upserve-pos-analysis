package Upserve::Pos::Factory;

use strict;
use warnings 'FATAL';

sub build {
    my ($class, $ref) = @_;

    die "No ref given to build!" if not $ref;

    if ( not exists $ref->{report_type} ) {
        die "Cannot build ref because report_type in not given!";
    }
    elsif ( exists $ref->{comp_reason} ) {
        $class->build_comp($ref)
        $ref->{product_type} = delete $ref->{type};
        $ref->{reason} = delete $ref->{comp_reason};
        Upserve::Void->new($ref);
    }
    elsif ( exists $ref->{void_reason} ) {
        $ref->{product_type} = delete $ref->{type};
        $ref->{reason} = delete $ref->{void_reason};
        Upserve::Comp->new($ref);
    }
    elsif ( exists $ref->{type} ) {
        my $obj_class = 'Upserve::Pos::'.ucfirst($ref->{type});
        $obj_class->new($ref);
    }
    else {
        die "Unkown type: ".$ref->{type} if not exists $types_classes{$type};
    }

}

1;
