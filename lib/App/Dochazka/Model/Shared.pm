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

package App::Dochazka::Model::Shared;

use 5.012;
use strict;
use warnings FATAL => 'all';

use Params::Validate qw( :all );



=head1 NAME

App::Dochazka::Model::Shared - functions shared by several modules within
the data model




=head1 VERSION

Version 0.147

=cut

our $VERSION = '0.147';




=head1 SYNOPSIS

Shared data model functions.




=head1 FUNCTIONS


=head2 make_spawn

Returns a ready-made 'spawn' method. 

=cut

sub make_spawn {
    return sub {
        # process arguments
        my ( $class, @ARGS ) = @_;
        #die "Odd number of arguments (" . scalar @ARGS . ") in PARAMHASH: " . stringify_args( @ARGS ) if @ARGS and (@ARGS % 2);
        my %ARGS = @ARGS;

        # bless, reset, return
        my $self = bless {}, $class;
        $self->reset( %ARGS ); # make sure we have all required attributes
        return $self;
    }
}


=head2 make_reset

Given a list of attributes, returns a ready-made 'reset' method. 

=cut

sub make_reset {

    # take a list consisting of the names of attributes that the 'reset'
    # method will accept -- these must all be scalars
    my ( @attr ) = validate_pos( @_, map { { type => SCALAR }; } @_ );

    # construct the validation specification for the 'reset' routine:
    # 1. 'reset' will take named parameters _only_
    # 2. only the values from @attr will be accepted as parameters
    # 3. all parameters are optional
    my $val_spec;
    map { $val_spec->{$_} = 0; } @attr;
    
    return sub {
        # process arguments
        my $self = shift;
        #confess "Not an instance method call" unless ref $self;
        my %ARGS = validate( @_, $val_spec ) if @_ and defined $_[0];

        # set attributes to run-time values sent in argument list
        map { $self->{$_} = $ARGS{$_}; } @attr;

        # run the populate function, if any
        $self->populate() if $self->can( 'populate' );

        # return an appropriate throw-away value
        return;
    }
}


=head2 make_accessor

Returns a ready-made accessor.

=cut

sub make_accessor {
    my ( $subname ) = @_;
    sub {
        my $self = shift;
        validate_pos( @_, { type => SCALAR, optional => 1 } );
        $self->{$subname} = shift if @_;
        return $self->{$subname};
    };
}




=head1 AUTHOR

Nathan Cutler, C<< <presnypreklad@gmail.com> >>

=cut 

1;

