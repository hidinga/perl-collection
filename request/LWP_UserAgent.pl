#!/usr/bin/perl

use utf8;
use Encode;
use Encode::CN;

use LWP::UserAgent;
# use HTTP::Cookies;
# use LWP::ConnCache;
# use LWP::Protocol::https;

my $uagent = LWP::UserAgent->new(use_eval => 1);
$uagent -> agent('Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.142 Safari/535.19');
$uagent -> timeout(180);
$uagent -> default_header('Host' => "www.oschina.net");

# $uagent->default_header('Content-Type' => 'application/json' );
# $uagent->default_header('Content_Type' => 'form-data;boundary=xYzZY');
# $uagent->default_header('Authorization', "Basic ".encode_base64("admin:password"));
    
# $uagent -> env_proxy;										            # 使用系统代理
# $uagent -> proxy('http', 'http://172.16.0.99:3128');		            # 使用http代理
# $uagent -> proxy([qw(http https)] => 'socks://172.16.3.21:7070');     # 使用sock代理

# $cookie = HTTP::Cookies->new;
# $uagent -> cookie_jar($cookie);

# $ucache = new LWP::ConnCache;
# $uagent -> conn_cache($ucache);

# GET

my $rs = $uagent -> get("http://www.test.cn"); 

print $rs->content if ($rs->is_success);
print $rs->status_line;

##########################################################################

# POST

my $rs = $uagent -> post( 'http://www.test.cn/login', [username => 'hidinga', password => 'test']); 
print $rs->content if ($rs->is_success);
print $rs->status_line;

#

my $data1 = ["username" => 'ping.bao', "password" => '123456'];
my $data2 = {"username" => 'ping.bao', "password" => '123456', "password[a]" => '123456'};
my %data3 = ("username" => 'ping.bao', "password" => '123456');

$rs = $uagent -> post( 'http://www.test.cn/', $data1);
$rs = $uagent -> post( 'http://www.test.cn/', $data2);
$rs = $uagent -> post( 'http://www.test.cn/', \%data3);

# MIME :  xls = Content_Type => 'application/vnd.ms-excel'
# MIME : xlsx = Content_Type => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
# MIME :  dat = Content_Type => 'application/octet-stream'
# MIME : json = Content_Type => 'application/json'
# MIME :  pdf = Content_Type => 'application/pdf'
# MIME :  txt = Content_Type => 'text/plain'
# MIME :  jpg = Content_Type => 'image/jpeg'
# MIME :  png = Content_Type => 'image/png'
# MIME :  gif = Content_Type => 'image/gif'

# POST FILE

my %post_hash = (
    ticker => '510050', 
    file => [encode("gbk", "D:\My Documents\a.jpg"), Encode::encode_utf8("照片.jpg"), Content_Type => 'image/jpeg']
);
my $ref = $uagent->post( 'http://www.tinypic.com/', Content_Type => 'multipart/form-data', Content => \%post_hash );
print $ref->content if ($ref->is_success);

# HEADER

my $rs = $uagent -> get("http://www.test.cn"); 

foreach ($rs->header_field_names()) { 
	printf("%30s : %-s\n", $_, $rs->header($_));
}
print $rs->header("Server");
print $rs->content;

# REDIRECT

my $ref = $uagent -> get("http://www.test.cn"); 
my $url = $ref->header('Location');
my $new = $uagent -> get($url);
print $new->status_line;
print $new->content if ($new->is_success);
