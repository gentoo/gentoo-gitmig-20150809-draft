# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-5.0.0.ebuild,v 1.1 2004/07/22 13:11:55 stuart Exp $

PHPSAPI="cgi"
MY_P="php-${PVR}"

inherit php5-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
KEYWORDS="-x86 -sparc -alpha -hppa -ppc"

# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-5.0.0"

src_compile() {
	# CLI needed to build stuff
	my_conf="${my_conf} \
		--enable-cgi \
		--enable-cli \
		--enable-fastcgi"

	php5-sapi_src_compile
}


src_install() {
	PHP_INSTALLTARGETS="install"
	php5-sapi_src_install

	# rename binary
	mv ${D}/usr/bin/php ${D}/usr/bin/php-cgi
}

pkg_postinst() {
	einfo "This is a CGI only build."
}
