# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.3.6.ebuild,v 1.3 2004/05/04 02:17:38 robbat2 Exp $

PHPSAPI="cgi"
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"

src_compile() {
	# CLI needed to build stuff
	myconf="${myconf} \
		--enable-cgi \
		--enable-cli \
		--enable-fastcgi"

	php-sapi_src_compile
}


src_install() {
	PHP_INSTALLTARGETS="install"
	php-sapi_src_install

	# rename binary
	mv ${D}/usr/bin/php ${D}/usr/bin/php-cgi
}

pkg_postinst() {
	php-sapi_pkg_postinst
	einfo "This is a CGI only build."
}
