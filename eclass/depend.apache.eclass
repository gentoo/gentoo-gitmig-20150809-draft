# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/depend.apache.eclass,v 1.36 2008/02/02 12:53:52 hollow Exp $

# @ECLASS: depend.apache.eclass
# @MAINTAINER: apache-devs@gentoo.org
# @BLURB: Functions to allow ebuilds to depend on apache
# @DESCRIPTION:
# This eclass handles depending on apache in a sane way and providing
# information about where certain interfaces are located.
#
# @NOTE: If you use this, be sure you use the need_* call after you have defined
# DEPEND and RDEPEND. Also note that you can not rely on the automatic
# RDEPEND=DEPEND that portage does if you use this eclass.
#
# See bug 107127 for more information.

inherit multilib

# ==============================================================================
# INTERNAL VARIABLES
# ==============================================================================

# @ECLASS-VARIABLE: APACHE_VERSION
# @DESCRIPTION:
# Stores the version of apache we are going to be ebuilding. This variable is
# set by the need_apache functions.

# @ECLASS-VARIABLE: APXS
# @DESCRIPTION:
# Paths to the apxs tool

# @ECLASS-VARIABLE: APACHECTL
# @DESCRIPTION:
# Path to the apachectl tool

# @ECLASS-VARIABLE: APACHE_BASEDIR
# @DESCRIPTION:
# Path to the server root directory

# @ECLASS-VARIABLE: APACHE_CONFDIR
# @DESCRIPTION:
# Path to the configuration file directory

# @ECLASS-VARIABLE: APACHE_MODULES_CONFDIR
# @DESCRIPTION:
# Path where module configuration files are kept

# @ECLASS-VARIABLE: APACHE_VHOSTS_CONFDIR
# @DESCRIPTION:
# Path where virtual host configuration files are kept

# @ECLASS-VARIABLE: APACHE_MODULESDIR
# @DESCRIPTION:
# Path where we install modules

# @ECLASS-VARIABLE: APACHE2_DEPEND
# @DESCRIPTION:
# Dependencies for Apache 2.x
APACHE2_DEPEND="=www-servers/apache-2*"

# @ECLASS-VARIABLE: APACHE2_0_DEPEND
# @DESCRIPTION:
# Dependencies for Apache 2.0.x
APACHE2_0_DEPEND="=www-servers/apache-2.0*"

# @ECLASS-VARIABLE: APACHE2_2_DEPEND
# @DESCRIPTION:
# Dependencies for Apache 2.2.x
APACHE2_2_DEPEND="=www-servers/apache-2.2*"

# @ECLASS-VARIABLE: WANT_APACHE_DEPEND
# @DESCRIPTION:
# Dependency magic based on useflag to use the right DEPEND
WANT_APACHE_DEPEND="apache2? ( ${APACHE2_DEPEND} )"

# ==============================================================================
# INTERNAL FUNCTIONS
# ==============================================================================

# @FUNCTION: uses_apache2
# @DESCRIPTION:
# sets up all of the environment variables required for an apache2 module
uses_apache2() {
	debug-print-function $FUNCNAME $*

	# WARNING: Do not use these variables with anything that is put
	# into the dependency cache (DEPEND/RDEPEND/etc)
	APACHE_VERSION="2"
	APXS="/usr/sbin/apxs2"
	APACHECTL="/usr/sbin/apache2ctl"
	APACHE_BASEDIR="/usr/$(get_libdir)/apache2"
	APACHE_CONFDIR="/etc/apache2"
	APACHE_MODULES_CONFDIR="${APACHE_CONFDIR}/modules.d"
	APACHE_VHOSTS_CONFDIR="${APACHE_CONFDIR}/vhosts.d"
	APACHE_MODULESDIR="${APACHE_BASEDIR}/modules"
}

# @FUNCTION: doesnt_use_apache
# @DESCRIPTION:
# sets up all of the environment variables required for optional apache usage
doesnt_use_apache() {
	debug-print-function $FUNCNAME $*

	APACHE_VERSION="0"
	USE_APACHE="0"
}

# ==============================================================================
# PUBLIC FUNCTIONS
# ==============================================================================

# @FUNCTION: want_apache
# @DESCRIPTION:
# An ebuild calls this to get the dependency information for optional apache-2.x
# support.
want_apache() {
	debug-print-function $FUNCNAME $*

	IUSE="${IUSE} apache2"
	DEPEND="${DEPEND} ${WANT_APACHE_DEPEND}"
	RDEPEND="${RDEPEND} ${WANT_APACHE_DEPEND}"

	if use apache2 ; then
		uses_apache2
	else
		doesnt_use_apache
	fi
}

# @FUNCTION: need_apache2
# @DESCRIPTION:
# An ebuild calls this to get the dependency information for apache-2.x. An
# ebuild should use this in order for future changes to the build infrastructure
# to happen seamlessly. All an ebuild needs to do is include the line
# need_apache2 somewhere.
need_apache2() {
	debug-print-function $FUNCNAME $*

	DEPEND="${DEPEND} ${APACHE2_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE2_DEPEND}"
	uses_apache2
}

# @FUNCTION: need_apache2_0
# @DESCRIPTION:
# Works like need_apache2 above, but its used by modules that only support
# apache 2.0 and do not work with higher versions.
need_apache2_0() {
	debug-print-function $FUNCNAME $*

	DEPEND="${DEPEND} ${APACHE2_0_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE2_0_DEPEND}"
	uses_apache2
}

# @FUNCTION: need_apache2_2
# @DESCRIPTION:
# Works like need_apache2 above, but its used by modules that only support
# apache 2.2 and do not work with lower versions.
need_apache2_2() {
	debug-print-function $FUNCNAME $*

	DEPEND="${DEPEND} ${APACHE2_2_DEPEND}"
	RDEPEND="${RDEPEND} ${APACHE2_2_DEPEND}"
	uses_apache2
}

# @FUNCTION: need_apache
# @DESCRIPTION:
# Legacy alias for need_apache2
need_apache() {
	need_apache2
}
