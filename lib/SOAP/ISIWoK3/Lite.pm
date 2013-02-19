package SOAP::ISIWoK3::Lite;

use base qw( SOAP::ISIWoK3 );

use strict;

sub new
{
	my ($class, %self) = @_;

	$self{endpoint} ||= SOAP::ISIWoK3::WOKSEARCH_ENDPOINT;
	$self{service_type} ||= SOAP::ISIWoK3::WORKSEARCH_SERVICE_TYPE;

	return $class->SUPER::new(%self);
}

1;
