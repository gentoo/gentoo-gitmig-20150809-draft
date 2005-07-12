# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.4.0.ebuild,v 1.2 2005/07/12 09:04:56 sebastian Exp $

PHPSAPI="cgi"
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
IUSE="${IUSE} force-cgi-redirect"
KEYWORDS="x86 ~sparc ~alpha ~hppa ~ppc ~ia64 ~amd64 ~mips"

# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-4.3.11"
PROVIDE="${PROVIDE} virtual/httpd-php"

src_unpack() {
	php-sapi_src_unpack
}

src_compile() {
	# CLI needed to build stuff
	myconf="${myconf} \
		--enable-cgi \
		--enable-cli \
		--enable-fastcgi"

	if use force-cgi-redirect; then
		myconf="${myconf} --enable-force-cgi-redirect"
	fi

	php-sapi_src_compile
}

src_install() {
	PHP_INSTALLTARGETS="install"
	php-sapi_src_install

	rm -f ${D}/usr/bin/php
	# rename binary
	newbin ${S}/sapi/cgi/php php-cgi
}

pkg_postinst() {
	php-sapi_pkg_postinst
	einfo "This is a CGI only build."
}
