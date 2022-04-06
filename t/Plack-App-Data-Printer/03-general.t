use strict;
use warnings;

use HTTP::Request;
use Plack::App::Data::Printer;
use Plack::Test;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $data_hr = {
	'foo' => 'bar',
	'baz' => [1, 2],
};
my $app = Plack::App::Data::Printer->new(
	'data' => $data_hr,
);
my $test = Plack::Test->create($app);
my $res = $test->request(HTTP::Request->new(GET => '/'));
my $ret = $res->content;
my $right_ret = <<'END';
{
    baz   [
        [0] 1,
        [1] 2
    ],
    foo   "bar"
}
END
is($ret, $right_ret, 'Get content.');
