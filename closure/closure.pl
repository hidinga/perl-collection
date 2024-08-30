#!/usr/bin/perl

sub paint {
	
	my $color = shift;
	
	my $ref = sub {
		my $object = shift;
		sprintf "Paint the $object $color.\n";
	};
	return $ref;
}

my $p1 = paint("red");
print $p1->("flower");


my $p2 = paint("blue");
print $p2->("sky");