# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.4.0.ebuild,v 1.11 2005/08/16 04:07:37 vapier Exp $

PHPSAPI="cli"
inherit php-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

src_unpack() {
	php-sapi_src_unpack
	[ "${ARCH}" == "amd64" ] && epatch ${FILESDIR}/php-4.3.4-amd64hack.diff
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

	if [ -f "${ROOT}/root/.pearrc" -a "`md5sum ${ROOT}/root/.pearrc`" = "f0243f51b2457bc545158cf066e4e7a2  ${ROOT}/root/.pearrc" ]; then
		einfo "Cleaning up an old PEAR install glitch"
		mv ${ROOT}/root/.pearrc ${ROOT}/root/.pearrc.`date +%Y%m%d%H%M%S`
	fi
}
