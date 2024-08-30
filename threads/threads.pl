#!/usr/bin/perl

use LWP::UserAgent;
use Time::HiRes qw/sleep time/;
use Data::Dumper;

use threads;
use threads::shared;
use IO::Socket;

# 初始化

my $uagent = LWP::UserAgent->new(use_eval => 1);
$uagent -> agent('Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.142 Safari/535.19');
$uagent -> default_header('Host' => "video.fundsmart.com.cn");
$uagent -> timeout(180);

# 共享到线程, 用于子线程程获取任务列表

our @task :shared;       						

# 定义本次任务总数

@task = (1..20);                                

# 线程数为 2

for(1..2) {                                     
	threads->create(\&requestURL, $_);
}

while (threads->list(threads::running) ) {      # 等待线程结束
	sleep 1;
}

grep {$_->detach()} threads->list(threads::all); 

sub requestURL
{
    $SIG{'BREAK'} = sub {
       threads->exit()
    };
	
    while ( scalar(@task) > 0 )
    {
        my $num = shift @task;
        my $url = sprintf("http://video.fundsmart.com.cn/110011/%02s", $num);
		
		sleep 1;
		
        # my $ref = $uagent -> get($url);
        # printf("[%d] : %s = %s\n", threads->tid(), $url, $ref->status_line);
		
        printf("[%d] : %s\n", threads->tid(), $url);
    }
    threads->exit();
}