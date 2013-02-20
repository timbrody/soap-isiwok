#!/usr/bin/perl

=head1 NAME

isiwok.pl - test query tool for SOAP::ISIWoK

=head1 SYNOPSIS

To enable SOAP tracing do:

	perl -M"SOAP::Lite +trace" ./isiwok.pl

=cut

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use SOAP::ISIWoK v3.00;

my $wos = SOAP::ISIWoK->new;

print STDERR "Authenticating ...\n";

$wos->authenticate;

print STDERR "Enter a search query:\n";

while(<>)
{
	my $som = $wos->search($_,
		max => 5,
#		fields => [qw( email_addr )],
	);
	if ($som->fault) {
		warn $som->faultstring;
	}
	else {
		print $som->result->{records};
	}
}
