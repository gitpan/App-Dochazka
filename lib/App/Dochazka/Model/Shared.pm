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



=head1 NAME

App::Dochazka::Model::Shared - generate boilerplate code




=head1 VERSION

Version 0.181

=cut

our $VERSION = '0.181';



=head1 SYNOPSIS

    use App::Dochazka::Model::Shared;

    ...

=cut

# This routine requires some explanation. It takes a list of attributes
# (object property names), and returns a string that can be run through
# 'eval' to generate 'spawn', 'filter', 'reset', 'TO_JSON', 'compare',
# and 'clone' methods for a given class, as well as basic accessors for
# that class. Since this same code needs to be re-used for each class,
# I decided to have it in just one place at the expense of readability.
# 
# the EOH heredoc also deserves line-by-line commentary:
#
# no strict 'refs' is required for the *{"spawn"}, etc. constructs 
#
# require App::Dochazka::Model is required because we refer to it
# when executing the make_spawn, make_filter, etc. routines
#
# my %make = ( . . . sets up a dispatch table -- for a good explanation
# see http://stackoverflow.com/questions/1915616/how-can-i-elegantly-call-a-perl-subroutine-whose-name-is-held-in-a-variable
#
# *{"spawn"} = $make{"spawn"}->(); runs the make_spawn routine to 
# create the 'spawn' method
# 
# map { *{$_} = $make{$_}->( ATTRS ); } qw( filter reset TO_JSON compare clone );
# runs the make_filter, make_reset, etc. routines, with the
# contents of the ATTRS constant as the argument
#
# map { *{$_} = $make{"accessor"}->( $_ ); } ATTRS;
# runs the make_accessor routine once for each element of the ATTRS list
# (this generates the basic accessors)
#
# After the heredoc a qw( ... ) string is constructed from the 
# @attrs array and this string is substituted for all occurrences
# of the string ATTRS in the heredoc
#
# finally, the modified heredoc is returned to the caller
sub boilerplate {
    my @attrs = @_;

    my $bpc = <<'EOH';
    no strict 'refs';
    require App::Dochazka::Model;
    my %make = (
        spawn => \&App::Dochazka::Model::make_spawn,
        filter => \&App::Dochazka::Model::make_filter,
        reset => \&App::Dochazka::Model::make_reset,
        TO_JSON => \&App::Dochazka::Model::make_TO_JSON,
        compare => \&App::Dochazka::Model::make_compare,
        clone => \&App::Dochazka::Model::make_clone,
        accessor => \&App::Dochazka::Model::make_accessor,
    );
    *{"spawn"} = $make{"spawn"}->();
    map {
        *{$_} = $make{$_}->( ATTRS );
    } qw( filter reset TO_JSON compare clone );
    map {
        *{$_} = $make{"accessor"}->( $_ );
    } ATTRS;
EOH

    my $attr_str = "qw( ";
    map { $attr_str .= $_; $attr_str .= ' '; } @attrs;
    $attr_str .= ')';

    $bpc =~ s/ATTRS/$attr_str/gs;

    return $bpc;
}

1;
