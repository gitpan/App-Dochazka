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

package App::Dochazka::Model::Interval;

use 5.012;
use strict;
use warnings FATAL => 'all';

use App::Dochazka::Model::Shared;



=head1 NAME

App::Dochazka::Model::Interval - activity intervals data model




=head1 VERSION

Version 0.153

=cut

our $VERSION = '0.153';




=head1 SYNOPSIS

Activity intervals data model.




=head1 DESCRIPTION

Activity intervals data model.




=head1 METHODS

=head2 spawn

Constructor. See Employee.pm->spawn for general comments.

=cut

BEGIN {
    no strict 'refs';
    *{"spawn"} = App::Dochazka::Model::Shared::make_spawn();
}



=head2 reset

Boilerplate.

=cut

BEGIN {
    no strict 'refs';
    *{"reset"} = App::Dochazka::Model::Shared::make_reset(
        'iid', 'eid', 'aid', 'intvl', 'long_desc', 'remark'
    );
}



=head2 Accessor methods

Boilerplate.

=cut

BEGIN {
    foreach my $subname ( 'iid', 'eid', 'aid', 'intvl', 'long_desc', 'remark' ) {
        no strict 'refs';
        *{"$subname"} = App::Dochazka::Model::Shared::make_accessor( $subname );
    }   
}

=head3 iid

Accessor method.


=head3 eid

Accessor method.


=head3 aid

Accessor method.


=head3 intvl

Accessor method.


=head3 long_desc

Accessor method.


=head3 remark

Accessor method.

=cut

1;
