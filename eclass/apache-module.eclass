# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael Tindal <urilith@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/apache-module.eclass,v 1.1 2004/11/21 01:51:58 urilith Exp $
ECLASS=apache-module
INHERITED="$INHERITED $ECLASS"

inherit depend.apache

# This eclass provides a common set of functions for Apache modules.

######
## Common ebuild variables
######

####
## APXS1_S, APXS2_S
##
## Paths to temporary build directories
####
APXS1_S=""
APXS2_S=""

####
## APXS1_ARGS, APXS2_ARGS
##
## Arguments to pass to the apxs tool
####
APXS1_ARGS=""
APXS2_ARGS=""

####
## APACHE1_MOD_FILE, APACHE2_MOD_FILE
##
## Name of the module that src_install installs (only, minus the .so)
####
APACHE1_MOD_FILE=""
APACHE2_MOD_FILE=""

####
## APACHE1_MOD_CONF, APACHE2_MOD_CONF
##
## Configuration file installed by src_install
####
APACHE1_MOD_CONF=""
APACHE2_MOD_CONF=""

####
## APACHE1_MOD_DEFINE, APACHE2_MOD_DEFINE
##
## Name of define (eg FOO) to use in conditional loading of the installed
## module/it's config file
####
APACHE1_MOD_DEFINE=""
APACHE2_MOD_DEFINE=""

####
## DOCFILES
##
## If the exported src_install() is being used, and ${DOCFILES} is non-zero,
## some sed-fu is applied to split out html documentation (if any) from normal
## documentation, and dodoc'd or dohtml'd
####
DOCFILES=""

######
## Utility functions
######

####
## apache_cd_dir
##
## Return the path to our temporary build dir
####
apache_cd_dir() {
	debug-print-function apache_cd_dir

	if [ "${APACHE_VERSION}" == "1" ]; then
		[ -n "${APXS1_S}" ] && CD_DIR="${APXS1_S}"
	else
		[ -n "${APXS2_S}" ] && CD_DIR="${APXS2_S}"
	fi

	# XXX - is this really needed? can't we just return ${S}?
	if [ -z "${CD_DIR}" ]; then
		if [ -d ${S}/src ] ; then
			CD_DIR="${S}/src"
		else
			CD_DIR="${S}"
		fi
	fi

	debug-print apache_cd_dir: "CD_DIR=${CD_DIR}"
	echo ${CD_DIR}
}

####
## apache_mod_file
##
## Return the path to the module file
####
apache_mod_file() {
	debug-print-function apache_mod_file

	if [ "${APACHE_VERSION}" == "1" ]; then
		[ -n "${APACHE1_MOD_FILE}" ] && MOD_FILE="${APACHE1_MOD_FILE}"
	    [ -z "${MOD_FILE}" ] && MOD_FILE="$(apache_cd_dir)/${PN}.so"
	else
		[ -n "${APACHE2_MOD_FILE}" ] && MOD_FILE="${APACHE2_MOD_FILE}"
	    [ -z "${MOD_FILE}" ] && MOD_FILE="$(apache_cd_dir)/.libs/${PN}.so"
	fi

	debug-print apache_mod_file: MOD_FILE=${MOD_FILE}
	echo ${MOD_FILE}
}

####
## apache_doc_magic
##
## Some magic for picking out html files from ${DOCFILES}.  It takes
## an optional first argument `html'; if the first argument is equals
## `html', only html files are returned, otherwise normal (non-html)
## docs are returned.
####
apache_doc_magic() {
	debug-print-function apache_doc_magic $*

	if [ -n "${DOCFILES}" ]; then
		if [ "x$1" == "xhtml" ]; then
			DOCS="`echo ${DOCFILES} | sed -e 's/ /\n/g' | sed -e '/^[^ ]*.html$/ !d'`"
		else
			DOCS="`echo ${DOCFILES} | sed 's, *[^ ]*\+.html, ,g'`"
		fi

		debug-print apache_doc_magic: DOCS=${DOCS}
		echo ${DOCS}
	fi
}

######
## Apache 1.x ebuild functions
######

####
## apache1_src_compile
## The default action is to call ${APXS11} with the value of
## ${APXS1_ARGS}.  If a module requires a different build setup
## than this, use ${APXS1} in your own src_compile routine.
####
apache1_src_compile () {
	debug-print-function apache1_src_compile

	CD_DIR=$(apache_cd_dir)
	cd ${CD_DIR} || die "cd ${CD_DIR} failed"
	APXS1_ARGS="${APXS1_ARGS:--c ${PN}.c}"
	${APXS1} ${APXS1_ARGS} || die "${APXS1} ${APXS1_ARGS} failed"
}

####
## apache1_src_install
##
## This installs the files into apache's directories.  The module is installed
## from a directory chosen as above (APXS2_S or ${S}/src).  In addition,
## this function can also set the executable permission on files listed in EXECFILES.
## The configuration file name is listed in APACHE1_MOD_CONF without the .conf extensions,
## so if you configuration is 55_mod_foo.conf, APACHE1_MOD_CONF would be 55_mod_foo.
## DOCFILES contains the list of files you want filed as documentation. The name of the 
## module can also be specified using the APACHE1_MOD_FILE or defaults to
## .libs/${PN}.so. 
####
apache1_src_install() {
	debug-print-function apache1_src_install

	CD_DIR=$(apache_cd_dir)
	cd ${CD_DIR} || die "cd ${CD_DIR} failed"

	MOD_FILE=$(apache_mod_file)

	exeinto ${APACHE1_MODULESDIR}
	doexe ${MOD_FILE} || die "internal ebuild error: \'${MOD_FILE}\' not found"
	[ -n "${APACHE1_EXECFILES}" ] && doexe ${APACHE1_EXECFILES}

	if [ -n "${APACHE1_MOD_CONF}" ] ; then
		insinto ${APACHE1_MODULES_CONFDIR}
		doins ${FILESDIR}/${APACHE1_MOD_CONF}.conf || die "internal ebuild error: \'${APACHE2_MOD_CONF}.conf\' not found."

		einfo
		einfo "Configuration file installed as ${APACHE1_MODULES_CONFDIR}/${APACHE1_MOD_CONF}.conf"
		einfo "You may want to edit it before turning the module on in /etc/conf.d/apache"
		einfo
	fi
	
	cd ${S}

	if [ -n "${DOCFILES}" ] ; then
		OTHER_DOCS=$(apache_doc_magic)
		HTML_DOCS=$(apache_doc_magic html)

		[ -n "${OTHER_DOCS}" ] && dodoc ${OTHER_DOCS}
		[ -n "${HTML_DOCS}" ] && dohtml ${HTML_DOCS}
	fi
}

####
## apache1_pkg_postinst
##
## Prints the standard config message, unless APACHE1_NO_CONFIG is set to yes.
####
apache1_pkg_postinst() {
	debug-print-function apache1_pkg_postinst

	if [ -n "${APACHE1_MOD_DEFINE}" ]; then
		einfo
		einfo "To enable ${PN}, you need to edit your /etc/conf.d/apache file and"
		einfo "add '-D ${APACHE1_MOD_DEFINE}' to APACHE_OPTS."
		einfo
	fi
}

######
## Apache 2.x ebuild functions
######

####
## apache2_pkg_setup
##
## Checks to see if APACHE2_MT_UNSAFE is set to anything other than "no".  If it is, then
## we check what the MPM style used by Apache is, if it isnt prefork, we let the user
## know they need prefork, and then exit the build.
####
apache2_pkg_setup () {
	debug-print-function apache2_pkg_setup

	if [ -n "${APACHE2_MT_UNSAFEE}" ]; then
		if [ "x${APACHE2_MT_UNSAFE}" != "no" ]; then
			APACHE2_MPM_STYLE=`/usr/sbin/apxs2 -q MPM_NAME`
			if [ "x$APACHE2_MPM_STYLE" != "xprefork" ]; then
				eerror "You currently have Apache configured to use the."
				eerror "$APACHE2_MPM_STYLE MPM style.  The module you are"
				eerror "trying to install is not currently thread-safe,"
				eerror "and will not work under your current configuraiton."
				echo
				eerror "If you still want to use the module, please reinstall"
				eerror "Apache with mpm-prefork set."

				epause
				ebeep
				die Invalid Apache MPM style.
			fi
		fi
	fi
}
				
####
## apache2_src_compile
##
## The default action is to call ${APXS2} with the value of
## ${APXS2_ARGS}.  If a module requires a different build setup
## than this, use ${APXS2} in your own src_compile routine.
####
apache2_src_compile () {
	debug-print-function apache2_src_compile

	CD_DIR=$(apache_cd_dir)
	cd ${CD_DIR} || die "cd ${CD_DIR} failed"
	APXS2_ARGS="${APXS2_ARGS:--c ${PN}.c}"
	${APXS2} ${APXS2_ARGS} || die "${APXS2} ${APXS2_ARGS} failed"
}

####
## apache2_src_install
##
## This installs the files into apache's directories.  The module is installed
## from a directory chosen as above (APXS2_S or ${S}/src).  In addition,
## this function can also set the executable permission on files listed in EXECFILES.
## The configuration file name is listed in CONFFILE without the .conf extensions,
## so if you configuration is 55_mod_foo.conf, CONFFILE would be 55_mod_foo.
## DOCFILES contains the list of files you want filed as documentation.
####
apache2_src_install() {
	debug-print-function apache2_src_install

	CD_DIR=$(apache_cd_dir)
	cd ${CD_DIR} || die "cd ${CD_DIR} failed"

	MOD_FILE=$(apache_mod_file)

	exeinto ${APACHE2_MODULESDIR}
	doexe ${MOD_FILE} || die "internal ebuild error: \'${MOD_FILE}\' not found"
	[ -n "${APACHE2_EXECFILES}" ] && doexe ${APACHE2_EXECFILES}

	if [ -n "${APACHE2_MOD_CONF}" ] ; then
		insinto ${APACHE2_MODULES_CONFDIR}
		doins ${FILESDIR}/${APACHE2_MOD_CONF}.conf || die "internal ebuild error: \'${APACHE2_MOD_CONF}.conf\' not found."

		einfo
		einfo "Configuration file installed as ${APACHE2_MODULES_CONFDIR}/${APACHE2_MOD_CONF}.conf"
		einfo "You may want to edit it before turning the module on in /etc/conf.d/apache2"
		einfo
	fi

	if [ -n "${APACHE2_VHOSTFILE}" ]; then
		insinto ${APACHE2_MODULES_VHOSTDIR}
		doins ${FILESDIR}/${APACHE2_VHOSTFILE}.conf
	fi

	cd ${S}

	if [ -n "${DOCFILES}" ] ; then
		OTHER_DOCS=$(apache_doc_magic)
		HTML_DOCS=$(apache_doc_magic html)

		[ -n "${OTHER_DOCS}" ] && dodoc ${OTHER_DOCS}
		[ -n "${HTML_DOCS}" ] && dohtml ${HTML_DOCS}
	fi
}

apache2_pkg_postinst() {
	debug-print-function apache2_pkg_postinst

	if [ -n "${APACHE2_MOD_DEFINE}" ]; then
		einfo
		einfo "To enable ${PN}, you need to edit your /etc/conf.d/apache2 file and"
		einfo "add '-D ${APACHE2_MOD_DEFINE}' to APACHE2_OPTS."
		einfo
	fi
}

######
## Apache dual (1.x or 2.x) ebuild functions
##
## This is where the magic happens.  We provide dummy routines of all of the functions
## provided by all of the specifics.  We use APACHE_ECLASS_VER_* to see which versions
## to call.  If a function is provided by a given section (ie pkg_postinst in Apache 2.x)
## the exported routine simply does nothing.
######

apache-module_pkg_setup() {
	debug-print-function apache-module_pkg_setup

	if [ ${APACHE_VERSION} -eq '2' ]; then
		apache2_pkg_setup
	fi
}

apache-module_src_compile() {
	debug-print-function apache-module_src_compile

	if [ ${APACHE_VERSION} -eq '1' ]; then
		apache1_src_compile
	else
		apache2_src_compile
	fi
}

apache-module_src_install() {
	debug-print-function apache-module_src_install

	if [ ${APACHE_VERSION} -eq '1' ]; then
		apache1_src_install
	else
		apache2_src_install
	fi
}

apache-module_pkg_postinst() {
	debug-print-function apache-module_pkg_postinst

	if [ ${APACHE_VERSION} -eq '1' ]; then
		apache1_pkg_postinst
	else
		apache2_pkg_postinst
	fi
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install pkg_postinst

# vim:ts=4
