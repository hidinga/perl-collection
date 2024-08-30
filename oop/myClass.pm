#!/usr/bin/perl

use strict;
use Data::Dumper;

# 根类, 合并子类数据

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

# 子类

package myClass;

use parent qw(baseClass);

sub new {

    # 调用父类的 new 并提交数据作为参数
    # 最后一个 shift 用于接收孙类提交的参数, 一并提交父类合并
    
    my $self = shift->SUPER::new(@_, {
        "startDate" => "2020-01-01",
              "tag" => "B",
             "diff" => 999
    }, shift);
    return $self;
}

1;