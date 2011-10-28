use inc::Module::Install;

# Define metadata
name            'Games-RollDice';
all_from        'lib/Games/RollDice.pm';

# Specific dependencies
test_requires   'Test::More'        => '0.88';

WriteAll;
