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
use SOAP::ISIWoK::Lite;
use Getopt::Long;
use Pod::Usage;

my %opts = (
	fields => [],
	offset => 0,
	max => 5,
);
GetOptions(\%opts,
	'help',
	'offset=i',
	'max=i',
	'fields=s',
	'lite',
) or pod2usage(1);

pod2usage(1) if $opts{help};

my $wos = $opts{lite} ?
	SOAP::ISIWoK::Lite :
	SOAP::ISIWoK->new;

print STDERR "Authenticating ...\n";

$wos->authenticate;

print STDERR "Enter a search query:\n";

while(<>)
{
	my $som = $wos->search($_,%opts);
	if ($som->fault) {
		warn $som->faultstring;
	}
	else {
		print $som->result->{records};
	}
}
