# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.3.9_rc1.ebuild,v 1.2 2005/01/09 21:02:39 weeve Exp $

PHPSAPI="cgi"
SRC_URI_BASE="http://downloads.php.net/ilia/" # for RC only
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~hppa ~ppc ~ia64"

# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-4.3.8"
PROVIDE="${PROVIDE} virtual/httpd-php-${PV}"

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
