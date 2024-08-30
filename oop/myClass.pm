#!/usr/bin/perl

use strict;
use Data::Dumper;

# ����, �ϲ���������

package baseClass;

sub new { 
	print Dumper @_;
	print "\n";

	my $class = shift;    
	my $self = {
		   "root" => "root",
			"tag" => "A",
	  "startDate" => "2010-01-01"
	};
	foreach(@_) {
		if(ref $_ eq "HASH"){
			foreach my $k(keys %{$_}){
				$self->{$k} = $_->{$k};
			}
		} 
	}
	bless $self, $class;
	return $self; 
}

1;

# ����

package myClass;

use parent qw(baseClass);

sub new {

    # ���ø���� new ���ύ������Ϊ����
    # ���һ�� shift ���ڽ��������ύ�Ĳ���, һ���ύ����ϲ�
    
    my $self = shift->SUPER::new(@_, {
        "startDate" => "2020-01-01",
              "tag" => "B",
             "diff" => 999
    }, shift);
    return $self;
}

1;