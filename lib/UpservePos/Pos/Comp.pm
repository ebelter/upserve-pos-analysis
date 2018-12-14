package Upserve::Pos::Comp;

use strict;
use warnings 'FATAL';

use base 'Upserve::Pos::CompVoid';

sub type { 'comp' }
sub product_type { $_[0]->{type} }

1;
