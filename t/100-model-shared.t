# ************************************************************************* 
# Copyright (c) 2014, SUSE LLC
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of SUSE LLC nor the names of its contributors may be
# used to endorse or promote products derived from this software without
# specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# ************************************************************************* 
#
# unit tests for Shared.pm
#

#!perl

use 5.012;
use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use Test::Fatal;
use Test::More;

use App::Dochazka::Model::Shared;

BEGIN {
    no strict 'refs';
    *{"spawn"} = App::Dochazka::Model::Shared::make_spawn;
    *{"reset"} = App::Dochazka::Model::Shared::make_reset( 'naivetest' );
    *{"naivetest"} = App::Dochazka::Model::Shared::make_accessor( 'naivetest' );
}

# make_spawn
like( exception{ __PACKAGE__->spawn( 1 ); }, qr/Odd number of parameters/ );
like( exception{ __PACKAGE__->spawn( foo => 'bar' ); }, qr/not listed in the validation options: foo/ );
my $object = __PACKAGE__->spawn( naivetest => 'Huh?' );
is( ref $object, __PACKAGE__ );
is( $object->naivetest, 'Huh?' );

# make_reset
$object->reset;
ok( ! defined( $object->naivetest ) );
$object->reset( naivetest => 'Bohuslav' );
is( $object->naivetest, 'Bohuslav' );

# make_accessor
$object->naivetest( 'Fandango' );
is( $object->naivetest, 'Fandango' );

done_testing;
