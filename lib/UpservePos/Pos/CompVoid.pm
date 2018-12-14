package Upserve::Pos::CompVoid;

use strict;
use warnings 'FATAL';

use base 'Class::Accessor';
Class::Accessor->mk_accessors(qw/ date reason item amount note check_owner authorized_by check_number /);

sub new { bless $_[1], $_[0] }

1;
