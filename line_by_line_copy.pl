#!/usr/bin/perl -w
use 5.010;
use strict;
use warnings;

my $in_file = 'in';
my $out_file = "simple_out";

open my $in, "<", $in_file or die;
open my $out, ">", $out_file or die;

print $out $_ while (<$in>);
close $in;
close $out;
