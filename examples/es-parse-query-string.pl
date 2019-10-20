#!/usr/bin/env perl
#
#
use strict;
use warnings;

use App::ElasticSearch::Utilities::QueryString;
use CLI::Helpers qw(:output);
use Getopt::Long;
use JSON::MaybeXS;

my %OPT;
GetOptions(\%OPT, qw(
        or
));
my $json  = JSON->new->ascii->canonical(1)->pretty;
my $qs    = App::ElasticSearch::Utilities::QueryString->new(
                default_join => $OPT{or} ? 'OR' : 'AND',
);
my $query = $qs->expand_query_string(@ARGV);

output({color=>'cyan'}, "Request URI Params:");
output($json->encode($query->uri_params));

output({clear=>1,color=>'yellow'}, "Request Body:");
output($json->encode($query->request_body));
