# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_httpbl/mod_httpbl-1.5.ebuild,v 1.1 2009/11/26 10:37:09 flameeyes Exp $

EAPI=2

inherit apache-module

DESCRIPTION="http:BL implementation for Apache 2"
HOMEPAGE="http://www.projecthoneypot.org/httpbl_download.php"
SRC_URI="http://httpbl.cvs.sourceforge.net/viewvc/*checkout*/httpbl/mod_httpbl_for_apache_2.0/mod_httpbl_source/mod_httpbl.c?revision=${PV} -> ${P}.c"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64"

S=${WORKDIR}

APACHE2_MOD_FILE=".libs/${PN}.so"
APACHE2_MOD_CONF="99_mod_httpbl"
APACHE2_MOD_DEFINE="HTTPBL"

need_apache2

# We have to copy the file in the work directory because otherwise
# apxs will try to build it within distdir (which is luckily read
# only).
src_unpack() {
	cp "${DISTDIR}"/${P}.c ${PN}.c || die
}

src_compile() {
	APXS_FLAGS=
	for flag in ${CFLAGS}; do
		APXS_FLAGS="${APXS_FLAGS} -Wc,${flag}"
	done

	# Yes we need to prefix it _twice_
	for flag in ${LDFLAGS}; do
		APXS_FLAGS="${APXS_FLAGS} -Wl,${flag}"
	done

	${APXS} -c ${APXS_FLAGS} ${PN}.c || die
}

src_install() {
	apache-module_src_install

	keepdir /var/log/apache2/httpbl
	fowners apache:apache /var/log/apache2/httpbl || die
	fperms 0770 /var/log/apache2/httpbl || die

	keepdir /var/cache/mod_httpbl || die
	fowners apache:apache /var/cache/mod_httpbl || die
	fperms 0770 /var/cache/mod_httpbl || die
}

pkg_postinst() {
	apache-module_pkg_postinst

	elog "To use http:BL you will need the API key from Project Honey Pot"
	elog "that you can receive being an active member."
	elog "See ${HOMEPAGE} for details."
	elog ""
	elog "By default all requests are filtered with the blacklist, you probably"
	elog "want to restrict that to virtual hosts where actual applications are"
	elog "running and/or on possibly vulnerable locations."
}
