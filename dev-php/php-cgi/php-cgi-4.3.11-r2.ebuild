# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.3.11-r2.ebuild,v 1.6 2005/10/29 22:16:13 chtekk Exp $

PHPSAPI="cgi"
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
IUSE="force-cgi-redirect"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc sparc x86"

# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-4.3.11"
PROVIDE="${PROVIDE} virtual/httpd-php"

# fixed PCRE library for security issues, bug #102373
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-pcrelib-new-secpatch.tar.bz2"

src_unpack() {
	php-sapi_src_unpack

	# Bug 88756
	use flash && epatch "${FILESDIR}/php-4.3.11-flash.patch"

	# Bug 88795
	use gmp && epatch "${FILESDIR}/php-4.3.11-gmp.patch"

	# fix imap symlink creation, bug #105351
	use imap && epatch "${FILESDIR}/php4.3.11-imap-symlink.diff"

	# we need to unpack the files here, the eclass doesn't handle this
	cd "${WORKDIR}"
	unpack php-pcrelib-new-secpatch.tar.bz2
	cd "${S}"

	# patch to fix PCRE library security issues, bug #102373
	epatch "${FILESDIR}/php4.3.11-pcre-security.patch"

	# sobstitute the bundled PCRE library with a fixed version for bug #102373
	einfo "Updating bundled PCRE library"
	rm -rf "${S}/ext/pcre/pcrelib" && mv -f "${WORKDIR}/pcrelib-new" "${S}/ext/pcre/pcrelib" || die "Unable to update the bundled PCRE library"
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

	rm -f "${D}/usr/bin/php"
	# rename binary
	newbin "${S}/sapi/cgi/php" php-cgi
}

pkg_postinst() {
	php-sapi_pkg_postinst
	einfo "This is a CGI only build."
}
