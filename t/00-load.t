#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    use_ok( 'App::Dochazka' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Activity' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Employee' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Interval' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Lock' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Privhistory' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Schedhistory' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Schedintvls' ) || print "Bail out!\n";
    use_ok( 'App::Dochazka::Model::Schedule' ) || print "Bail out!\n";
}

done_testing;

