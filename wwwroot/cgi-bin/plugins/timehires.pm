#!/usr/bin/perl
#-----------------------------------------------------------------------------
# TimeHires AWStats plugin
# Change time accuracy in showsteps option from seconds to milliseconds
#-----------------------------------------------------------------------------
# Perl Required Modules: Time::HiRes
#-----------------------------------------------------------------------------
# $Revision: 1.2 $ - $Author: eldy $ - $Date: 2002-07-27 17:07:40 $


use Time::HiRes qw( gettimeofday );
$Plugin_timehires=1;



#-----------------------------------------------------------------------------
# PLUGIN GLOBAL VARIABLES
#-----------------------------------------------------------------------------
#...


#-----------------------------------------------------------------------------
# PLUGIN Init_pluginname FUNCTION
#-----------------------------------------------------------------------------
sub Init_timehires {
	return 1;
}


#-----------------------------------------------------------------------------
# PLUGIN GetTime_pluginname FUNCTION
#-----------------------------------------------------------------------------
sub GetTime_timehires {
	my ($sec,$msec)=&gettimeofday();
	$_[0]=$sec;
	$_[1]=$msec;
}


#-----------------------------------------------------------------------------
# PLUGIN ShowField_pluginname FUNCTION
#-----------------------------------------------------------------------------
#...


#-----------------------------------------------------------------------------
# PLUGIN Filter_pluginname FUNCTION
#-----------------------------------------------------------------------------
#...



1;	# Do not remove this line
