# Copyright 2004-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/eclass/depend.apache.eclass,v 1.14 2005/05/12 18:50:01 kloeri Exp $
ECLASS=depend.apache
INHERITED="$INHERITED $ECLASS"

######
## Apache Common Variables
##
## These are internal variables used by this, and other apache-related eclasses,
## and thus should not need to be used by the ebuilds themselves (the ebuilds
## should know what version of Apache they are building against).
######

####
## APACHE_VERSION
##
## Stores the version of apache we are going to be ebuilding.  This variable is
## set by the need_apache{|1|2} functions.
##
## This needs to stay as '1' until apache2 is on by default -- although it
## doesn't matter much as it's set by the need_apache functions.
####
APACHE_VERSION='1'

####
## APXS1, APXS2
##
## Paths to the apxs tools
####
APXS1="/usr/sbin/apxs"
APXS2="/usr/sbin/apxs2"

####
## APACHECTL1, APACHECTL2
##
## Paths to the apachectl tools
####
APACHECTL1="/usr/sbin/apachectl"
APACHECTL2="/usr/sbin/apache2ctl"

####
## APACHE1_BASEDIR, APACHE2_BASEDIR
##
## Paths to the server root directories
####
APACHE1_BASEDIR="/usr/lib/apache"
APACHE2_BASEDIR="/usr/lib/apache2"

####
## APACHE1_CONFDIR, APACHE2_CONFDIR
##
## Paths to the configuration file directories (usually under
## $APACHE?_BASEDIR/conf)
####
APACHE1_CONFDIR="/etc/apache"
APACHE2_CONFDIR="/etc/apache2"

####
## APACHE1_MODULES_CONFDIR, APACHE2_MODULES_CONFDIR
##
## Paths where module configuration files are kept
####
APACHE1_MODULES_CONFDIR="${APACHE1_CONFDIR}/modules.d"
APACHE2_MODULES_CONFDIR="${APACHE2_CONFDIR}/modules.d"

####
## APACHE1_MODULES_VHOSTDIR, APACHE2_MODULES_VHOSTDIR
##
## Paths where virtual host configuration files are kept
####
APACHE1_VHOSTDIR="${APACHE1_CONFDIR}/vhosts.d"
APACHE2_VHOSTDIR="${APACHE2_CONFDIR}/vhosts.d"

####
## APACHE1_MODULESDIR, APACHE2_MODULESDIR
##
## Paths where we install modules
####
APACHE1_MODULESDIR="${APACHE1_BASEDIR}/modules"
APACHE2_MODULESDIR="${APACHE2_BASEDIR}/modules"

####
## APACHE1_DEPEND, APACHE2_DEPEND
##
## Dependencies for apache 1.x and apache 2.x
##  - apache2 must be at least version 2.0.52-r3, this is lowest version
##    containing our new overall changes -- trapni (Jan 21 2005)
##  - apache1 must be at least version 1.3.33-r1, but how to 
##    define the DEPEND here? (FIXME) -- trapni (Jan 21 2005)
##     - currently not possible - bug #4315 -- vericgar (Jan 21 2005)
####
APACHE1_DEPEND="=net-www/apache-1*"
APACHE2_DEPEND=">=net-www/apache-2.0.54-r5"


####
## APACHE_DEPEND
##
## Dependency magic based on useflags to use the right DEPEND
####

APACHE_DEPEND="apache2? ( ${APACHE2_DEPEND} ) !apache2? ( ${APACHE1_DEPEND} )"

####
## need_apache1
##
## An ebuild calls this to get the dependency information
## for apache-1.x.  An ebuild should use this in order for
## future changes to the build infrastructure to happen
## seamlessly.  All an ebuild needs to do is include the
## line need_apache1 somewhere.
####
need_apache1() {
	debug-print-function need_apache1

	DEPEND="${DEPEND} ${APACHE1_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE1_DEPEND}"
	APACHE_VERSION='1'
}

####
## need_apache2
##
## An ebuild calls this to get the dependency information
## for apache-2.x.  An ebuild should use this in order for
## future changes to the build infrastructure to happen
## seamlessly.  All an ebuild needs to do is include the
## line need_apache1 somewhere.
####
need_apache2() {
	debug-print-function need_apache2

	DEPEND="${DEPEND} ${APACHE2_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE2_DEPEND}"
	APACHE_VERSION='2'
}

####
## DO NOT CHANGE THIS FUNCTION UNLESS YOU UNDERSTAND THE CONSEQUENCES IT 
## WILL HAVE ON THE CACHE! There MUST be a apache2? () block in DEPEND for
## things to work correct in the dependency calculation stage.
####
need_apache() {
	debug-print-function need_apache

	IUSE="${IUSE} apache2"
	DEPEND="${DEPEND} ${APACHE_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE_DEPEND}"
	if useq apache2; then
		APACHE_VERSION='2'
		USE_APACHE2=2
		APXS="$APXS2"
		APACHECTL="${APACHECTL2}"
		APACHE_BASEDIR="${APACHE2_BASEDIR}"
		APACHE_CONFDIR="${APACHE2_CONFDIR}"
		APACHE_MODULES_CONFDIR="${APACHE2_MODULES_CONFDIR}"
		APACHE_VHOSTSDIR="${APACHE2_VHOSTSDIR}"
		APACHE_MODULESDIR="${APACHE2_MODULESDIR}"
	else
		APACHE_VERSION='1'
		APXS="$APXS1"
		USE_APACHE2=
		APACHECTL="${APACHECTL1}"
		APACHE_BASEDIR="${APACHE1_BASEDIR}"
		APACHE_CONFDIR="${APACHE1_CONFDIR}"
		APACHE_MODULES_CONFDIR="${APACHE1_MODULES_CONFDIR}"
		APACHE_VHOSTSDIR="${APACHE1_VHOSTSDIR}"
		APACHE_MODULESDIR="${APACHE1_MODULESDIR}"
	fi
}
