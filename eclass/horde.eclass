# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/horde.eclass,v 1.3 2004/04/06 00:34:36 vapier Exp $
#
# Help manage the horde project http://www.horde.org/
#
# Author: Mike Frysinger <vapier@gentoo.org>
# CVS additions by Chris Aniszczyk <zx@mea-culpa.net>
#
# This eclass provides generic functions to make the writing of horde
# ebuilds fairly trivial since there are many horde applications and 
# they all share the same basic install process.

# EHORDE_CVS
# This variable is just simply used to track whether the user is 
# using a cvs version of a horde ebulid.

inherit cvs webapp-apache

ECLASS=horde
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_setup src_unpack src_install pkg_postinst

[ -z "${HORDE_PN}" ] && HORDE_PN="${PN/horde-}"

if [ "${PN}" != "${PN/-cvs}" ] ; then
	ECVS_SERVER="anoncvs.horde.org:/repository"
	ECVS_MODULE="${HORDE_PN}"
	ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
	ECVS_USER="cvsread"
	ECVS_PASS="horde"

	HORDE_PN="${HORDE_PN/-cvs}"

	EHORDE_CVS="true"
	SRC_URI=""
	S=${WORKDIR}/${ECVS_MODULES}
else
	EHORDE_CVS="false"
	SRC_URI="http://ftp.horde.org/pub/${HORDE_PN}/${HORDE_PN}-${PV}.tar.gz"
	S=${WORKDIR}/${HORDE_PN}-${PV}
fi
HOMEPAGE="http://www.horde.org/${HORDE_PN}"

LICENSE="LGPL"
SLOT="0"

horde_pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"

	if [ ! -z "${HORDE_PHP_FEATURES}" ] ; then
		local phpver="`best_version mod_php`"
		local phpuse=" $(<${ROOT}/var/db/pkg/${phpver}/USE) "
		local found=0
		local myu=
		for myu in ${HORDE_PHP_FEATURES} ; do
			[ "${phpuse/ ${myu} }" != "${phpuse}" ] && found=1
		done
		if [ ${found} -eq 0 ] ; then
			eerror "You MUST re-emerge ${phpver} with at least one of"
			eerror "the following options in your USE:"
			eerror " ${HORDE_PHP_FEATURES}"
			die "current mod_php install cannot support ${HORDE_PN}"
		fi
	fi
}

horde_src_unpack() {
	if [ "${EHORDE_CVS}" == "true" ] ; then
		cvs_src_unpack
	else
		unpack ${A}
	fi
}

horde_src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/horde
	[ "${HORDE_PN}" != "horde" ] && destdir=${destdir}/${HORDE_PN}

	dodoc README docs/*
	rm -rf COPYING LICENSE README docs

	dodir ${destdir}

	# Work-around when dealing with CVS sources
	[ "${EHORDE_CVS}" == "true" ] && cd ${HORDE_PN}

	cp -r . ${D}/${destdir}/
	cd ${D}/${destdir}

	# protecting files
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${D}/${destdir}
	find ${D}/${destdir} -type f -exec chmod 0640 '{}' \;
	find ${D}/${destdir} -type d -exec chmod 0750 '{}' \;
}

horde_pkg_postinst() {
	if [ -e ${ROOT}/usr/share/doc/${PF}/INSTALL.gz ] ; then
		einfo "Please read /usr/share/doc/${PF}/INSTALL.gz"
	fi
	einfo "Before this package will work, you have to setup"
	einfo "the configuration files.  Please review the"
	einfo "config/ subdirectory of ${HORDE_PN} in the webroot."
	if [ "${HORDE_PN}" != "horde" ] ; then
		ewarn
		ewarn "Make sure ${HORDE_PN} is accounted for in horde's root"
		ewarn "    config/registry.php"
	fi
	if [ "${EHORDE_CVS}" == "true" ] ; then
		ewarn
		ewarn "Use these CVS versions at your own risk."
		ewarn "They tend to break things when working with" 
		ewarn "the non CVS versions of horde."
	fi
}
