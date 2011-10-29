
use strict;
use warnings;

use Games::RollDice;

use Test::Most;


my $num_iterations = $ENV{AUTOMATED_TESTING} ? 10 : 2;

for my $die (2..20)
{
    my %results;
    for (1..$die*$num_iterations)
    {
        my $roll = roll("d$die");
        is_valid(1, $roll, $die);
        ++$results{$roll};
    }

    if ($ENV{AUTOMATED_TESTING})
    {
        cmp_ok $results{$_}, '>=', 2, "reasonable distribution for d$die" foreach 1..$die;
    }
}

for my $num_dice (1..10)
{
    for my $die_size (4,6,8,10,12,20)
    {
        for (1..$num_iterations)
        {
            my @dice = roll("${num_dice}d$die_size");
            is @dice, $num_dice, "array of dice is proper size";
            is_valid(1, $_, $die_size) foreach @dice;

            my $total = roll("${num_dice}d$die_size");
            is_valid($num_dice, $total, $num_dice * $die_size);
        }
    }
}

done_testing();


sub is_valid
{
    my ($min, $val, $max) = @_;

    cmp_ok $val, '>=', $min, "result is within range (min: $min)";
    cmp_ok $val, '<=', $max, "result is within range (max: $max)";
    is $val, int($val), "result is an integer";
}
