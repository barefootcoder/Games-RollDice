
use strict;
use warnings;

use Games::RollDice;

use Test::Most;


for my $die (2..20)
{
	my %results;
	for (1..$die*10)
	{
		my $roll = roll("d$die");
		is_valid($roll, $die);
		++$results{$roll};
	}

	cmp_ok $results{$_}, '>=', 2, "reasonable distribution for d$die" foreach 1..$die;
}

done_testing();


sub is_valid
{
	my ($val, $max) = @_;

	cmp_ok $val, '>', 0, "result is positive";
	cmp_ok $val, '<=', $max, "result is within die size of $max";
	is $val, int($val), "result is an integer";
}
