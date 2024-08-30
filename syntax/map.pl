#!/usr/bin/perl

use utf8;
use Encode;
use Encode::CN;
use Data::Dumper;

# encode

print Dumper( [map { encode("gbk", $_) } ("名称", "类别", "数量", "盈亏比例")] );

# filter

@list = ( "Hello", 100, "World", 108 );
print Dumper( map { /^\d+/? $_ : () } @list );

# replace

@list = ("coding", "hidinga");
print Dumper( map { s/ing/e/; s/\.//; $_ } @list );

# intersection

my @a = ('a','b','c','d','e');
my @b = ('b','g','f','e');

my %a = map{$_ => 1} @a;
my %b = map{$_ => 1} @b;

print Dumper grep { $a{$_} } @b;

# union

print Dumper keys (map {$_ => 1} @a, @b);

# complement

print Dumper grep { !$a{$_} } keys (map {$_ => 1} @a, @b);