#!/usr/bin/perl
#-----------------------------------------------------------------------------
# GeoIp AWStats plugin
# This plugin allow you to get AWStats country report with countries detected
# from a Geographical database (GeoIP internal database) instead of domain
# hostname suffix.
#-----------------------------------------------------------------------------
# Perl Required Modules: Geo::IP
#-----------------------------------------------------------------------------
# $Revision: 1.8 $ - $Author: eldy $ - $Date: 2003-03-22 01:54:52 $


# <-----
# ENTER HERE THE USE COMMAND FOR ALL REQUIRED PERL MODULES
if (!eval ('require "Geo/IP.pm";')) 	{ return "Error: Need Perl module Geo::IP"; }
# ----->
use strict;no strict "refs";



#-----------------------------------------------------------------------------
# PLUGIN VARIABLES
#-----------------------------------------------------------------------------
# <-----
# ENTER HERE THE MINIMUM AWSTATS VERSION REQUIRED BY YOUR PLUGIN
# AND THE NAME OF ALL FUNCTIONS THE PLUGIN MANAGE.
my $PluginNeedAWStatsVersion="5.4";
my $PluginHooksFunctions="GetCountryCodeByAddr GetCountryCodeByName";
# ----->

# <-----
# IF YOUR PLUGIN NEED GLOBAL VARIABLES, THEY MUST BE DECLARED HERE.
use vars qw/
%TmpDomainLookup
$gi
/;
# ----->


#-----------------------------------------------------------------------------
# PLUGIN FUNCTION: Init_pluginname
#-----------------------------------------------------------------------------
sub Init_geoip {
	my $InitParams=shift;
	my $checkversion=&Check_Plugin_Version($PluginNeedAWStatsVersion);

	# <-----
	# ENTER HERE CODE TO DO INIT PLUGIN ACTIONS
	debug(" InitParams=$InitParams",1);
	my $mode=$InitParams;
	if ($mode eq '' || $mode eq 'GEOIP_MEMORY_CACHE')  { $mode=Geo::IP::GEOIP_MEMORY_CACHE(); }
	else { $mode=Geo::IP::GEOIP_STANDARD(); }
	%TmpDomainLookup=();
	debug(" GeoIP working in mode $mode",1);
	$gi = Geo::IP->new($mode);
	# ----->

	return ($checkversion?$checkversion:"$PluginHooksFunctions");
}


#-----------------------------------------------------------------------------
# PLUGIN FUNCTION: GetCountryCodeByName_pluginname
# UNIQUE: YES (Only one plugin using this function can be loaded)
# GetCountryCodeByName is called to translate a host name into a country name.
#-----------------------------------------------------------------------------
sub GetCountryCodeByName_geoip {
	# <-----
	my $res=$TmpDomainLookup{$_[0]}||'';
	if (! $res) {
		$res=lc($gi->country_code_by_name($_[0]));
		$TmpDomainLookup{$_[0]}=$res;
		if ($Debug) { debug(" GetCountryCodeByName for $_[0]: $res",5); }
	}
	elsif ($Debug) { debug(" GetCountryCodeByName for $_[0]: Already resolved to $res",5); }
	return $res;
	# ----->
}

#-----------------------------------------------------------------------------
# PLUGIN FUNCTION: GetCountryCodeByAddr_pluginname
# UNIQUE: YES (Only one plugin using this function can be loaded)
# GetCountryCodeByAddr is called to translate an ip into a country name.
#-----------------------------------------------------------------------------
sub GetCountryCodeByAddr_geoip {
	# <-----
	my $res=$TmpDomainLookup{$_[0]}||'';
	if (! $res) {
		$res=lc($gi->country_code_by_addr($_[0]));
		$TmpDomainLookup{$_[0]}=$res;
		if ($Debug) { debug(" GetCountryCodeByAddr for $_[0]: $res",5); }
	}
	elsif ($Debug) { debug(" GetCountryCodeByAddr for $_[0]: Already resolved to $res",5); }
	return $res;
	# ----->
}


1;	# Do not remove this line
