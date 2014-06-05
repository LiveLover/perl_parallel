#!/usr/bin/perl -w
use 5.010;
use strict;
use warnings;
use IO::Pipe;


my $in_file = 'in';
my $out_file = "out";
my $pipe = new IO::Pipe;

my $me;
my $pid;

if($pid = fork()){ #Parent
	$me = q/parent/;
	$pipe->writer();
	open my $input, "<", $in_file or die "Can not open file for read";
	while (<$input>) {
		print $pipe $_;
	}
	close $pipe;
	waitpid(-1 ,$pid);
} elsif( defined $pid ){ #Child
	$me = q/child/;
	$pipe->reader();
	open my $output, ">", $out_file or die "Can not open file for write";
	while (<$pipe>) {
		print $output $_;
	}
	$pipe->close();
}else {
	die "can not fork";
}

warn "END: $me";
