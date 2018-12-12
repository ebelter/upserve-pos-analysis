package UpservePos::Comp;

use strict;
use warnings 'FATAL';

use base 'UpservePos::CompVoid';

sub type { 'comp' }
sub product_type { $_[0]->{type} }

1;
