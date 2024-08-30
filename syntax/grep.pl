#!/usr/bin/perl -w

use Data::Dumper;

@list = ( "Hello", 100, 114, "World" );

print Dumper grep {/^[a-zA-Z]+/} @list;
