#!/usr/bin/perl -w


package YAML::ConfigFile;

require v5.6.0;
use strict;
use warnings;

=head1 NAME

YAML::ConfigFile - easily read configuration files in YAML format

=head1 SYNOPSIS

  use YAML::ConfigFile;

  my $c = YAML::ConfigFile->new($filename);

=head1 DESCRIPTION

YAML is a format for data serialization which also happens to be useful
for configuration files.  This module reads in a config file, strips
blank lines and comments (lines starting with #), and deserializes the
remaining lines, and returns a hashref of the data.

YAML itself has not yet been released on CPAN; you'll have to get a
tarball from Ingy or someone.

=cut

our $VERSION = '0.10';

use YAML;

sub new {
    shift;
    my $conffile = shift;

    my @lines;

    open FH, $conffile or return undef;
    while (<FH>) {
        next if /^#/;   # comments
        next if /^$/;   # blank lines
        push @lines, $_;
    }
    close FH;

    my @tmpcfg = YAML::deserialize(join '', @lines);
    my $self = \%{$tmpcfg[0]};

    bless $self;
    return $self;
}

return "FALSE";     # true value ;)

=head1 AUTHOR

Kirrily Robert <skud@cpan.org>

=head1 COPYING 

YAML::ConfigFile (c) 2001 Kirrily Robert <skud@cpan.org>
This software is distributed under the same licenses as Perl itself.

=head1 SEE ALSO

L<YAML>

=cut
