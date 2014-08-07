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

package App::Dochazka::Model::Employee;

use 5.012;
use strict;
use warnings FATAL => 'all';

use App::Dochazka::Model::Shared;




=head1 NAME

App::Dochazka::Model::Employee - Employee data model




=head1 VERSION

Version 0.147

=cut

our $VERSION = '0.147';




=head1 SYNOPSIS

Employee data model.




=head1 DESCRIPTION

Employee data model.




=head1 METHODS


=head2 spawn

Employee constructor. Does not interact with the database directly, but stores
database handle for later use. Optional parameter: PARAMHASH containing
definitions of any of the attributes listed in the 'reset' method.

=cut

BEGIN {
    no strict 'refs';
    *{"spawn"} = App::Dochazka::Model::Shared::make_spawn;
}



=head2 reset

Boilerplate.

=cut

BEGIN {
    no strict 'refs';
    *{"reset"} = App::Dochazka::Model::Shared::make_reset( 
        'eid', 'fullname', 'nick', 'email', 'passhash', 'salt', 'remark',
        'priv', 'schedule'
    );
}



=head2 Accessor methods

Boilerplate.

=cut

BEGIN {
    foreach my $subname ( 
        'eid', 'fullname', 'nick', 'email', 'passhash', 'salt', 'remark' 
    ) {
        no strict 'refs';
        *{"$subname"} = App::Dochazka::Model::Shared::make_accessor( $subname );
    }   
}


=head3 eid

Accessor method.

=head3 email

Accessor method.

=head3 fullname

Accessor method.

=head3 nick

Accessor method.

=head3 passhash

Accessor method.

=head3 salt

Accessor method.

=head3 remark

Accessor method.

=head3 priv

Accessor method. Meant to be overridden.

=cut

sub priv { 'passerby' };


=head3 schedule

Accessor method. Meant to be overriden.

=cut

sub schedule { {} };

1;
