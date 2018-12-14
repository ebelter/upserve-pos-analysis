package Upserve::Catalog::Item;

use strict;
use warnings 'FATAL';

use base 'Class::Accessor';
Class::Accessor->mk_accessors(qw/
    catalog_number vendor item category barcode units_in_package canister unit_quantity unit_of_measurement
    weighable minimum_order tax deposit price discount_percent final_price additional_tax
    can_be_ordered allow_return published
    /);

sub new { bless $_[1], $_[0] }

1;
