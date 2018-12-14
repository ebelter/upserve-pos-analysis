package Upserve::Pos::Item;

use strict;
use warnings 'FATAL';

use base 'Class::Accessor';
Class::Accessor->mk_accessors(qw/
    type id name sold void comp price cost gross comps total_tax net gross_profit
    receipt_total category_name category_id identifier
    /);

sub new { bless $_[1], $_[0] }

1;
