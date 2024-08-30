#!/usr/bin/perl

use strict;
use Data::Dumper;

# 调用子类

use myClass;
our @ISA = qw(myClass);

my $ddd = myClass->new({
	param => 123
});

print Dumper $ddd;