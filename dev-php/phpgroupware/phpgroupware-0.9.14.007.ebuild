# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpgroupware/phpgroupware-0.9.14.007.ebuild,v 1.6 2003/12/15 20:14:21 stuart Exp $

inherit webapp-apache

S=${WORKDIR}/${PN}

DESCRIPTION="intranet/groupware tool and application framework"
HOMEPAGE="http://www.phpgroupware.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~amd64 ~sparc ~hppa ~arm"

DEPEND="$DEPEND
    >=dev-php/mod_php-4.1
	dev-db/mysql"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old ${PN} version first."
		ewarn "${PN} will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	dodir ${destdir}
	#cd ${WORKDIR}
	cp -r . ${D}${destdir}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644
	dohtml ${PN}/doc/en_US/html/admin/*.html
}

pkg_postinst() {
	einfo "Follow the instructions at"
	einfo "/usr/share/doc/${PF}/html/x62.html#AEN134"
	einfo "to complete the install."
	einfo "You need to add MySQL users and configure ${PN}"
}
