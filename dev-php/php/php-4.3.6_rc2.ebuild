# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.3.6_rc2.ebuild,v 1.1 2004/04/05 20:55:09 robbat2 Exp $

PHPSAPI="cli"
SRC_URI_BASE="http://downloads.php.net/ilia/"
inherit php-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

src_unpack() {
	php-sapi_src_unpack
	if [ "${ARCH}" == "amd64" ] ; then
		epatch ${FILESDIR}/php-4.3.4-amd64hack.diff
	fi
}

src_compile() {
	myconf="${myconf} \
		--disable-cgi \
		--enable-cli"

	php-sapi_src_compile
}


src_install() {
	PHP_INSTALLTARGETS="install"
	php-sapi_src_install

	einfo "Installing manpage"
	doman sapi/cli/php.1
}

pkg_postinst() {
	php-sapi_pkg_postinst
	einfo "This is a CLI only build."
	einfo "You cannot use it on a webserver."

	if [ "`md5sum ${ROOT}/root/.pearrc`" = "f0243f51b2457bc545158cf066e4e7a2  ${ROOT}/root/.pearrc" ]; then
		einfo "Cleaning up an old PEAR install glitch"
		mv ${ROOT}/root/.pearrc ${ROOT}/root/.pearrc.`date +%Y%m%d%H%M%S`
	fi
}
