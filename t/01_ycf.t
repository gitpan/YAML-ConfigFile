#!perl -w

use Test::More no_plan;

package Catch;

sub TIEHANDLE {
    my($class) = shift;
    return bless {}, $class;
}

sub PRINT  {
    my($self) = shift;
    $main::_STDOUT_ .= join '', @_;
}

sub READ {}
sub READLINE {}
sub GETC {}

package main;

use lib "./lib";

local $SIG{__WARN__} = sub { $_STDERR_ .= join '', @_ };
tie *STDOUT, 'Catch' or die $!;

BEGIN: { use_ok('YAML::ConfigFile'); }

my $c = YAML::ConfigFile->new("t/test.conf");
can_ok('YAML::ConfigFile', 'new');
isa_ok($c, 'YAML::ConfigFile');
is($c->{database}, "support_test", "picked up ordinary field");
is($c->{logfile}, "/tmp/thomas.log", "picked up field after blank line");
is($c->{triggers}->{update}->[0], "icarus.pl", "picked up field after comment");
is($c->{triggers}->{update}->[1], undef, "don't pick up commented field");

