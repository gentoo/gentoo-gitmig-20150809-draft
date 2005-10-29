# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.4.0-r2.ebuild,v 1.7 2005/10/29 22:16:13 chtekk Exp $

PHPSAPI="cgi"
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
IUSE="fastcgi force-cgi-redirect"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"

# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-4.4.0"
PROVIDE="${PROVIDE} virtual/httpd-php"

# fixed PCRE library for security issues, bug #102373
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-pcrelib-new-secpatch.tar.bz2"

src_unpack() {
	php-sapi_src_unpack

	# fix imap symlink creation, bug #105351
	use imap && epatch "${FILESDIR}/php4.4.0-imap-symlink.diff"

	# we need to unpack the files here, the eclass doesn't handle this
	cd "${WORKDIR}"
	unpack php-pcrelib-new-secpatch.tar.bz2
	cd "${S}"

	# patch to fix PCRE library security issues, bug #102373
	epatch "${FILESDIR}/php4.4.0-pcre-security.patch"

	# sobstitute the bundled PCRE library with a fixed version for bug #102373
	einfo "Updating bundled PCRE library"
	rm -rf "${S}/ext/pcre/pcrelib" && mv -f "${WORKDIR}/pcrelib-new" "${S}/ext/pcre/pcrelib" || die "Unable to update the bundled PCRE library"
}

src_compile() {
	myconf="${myconf} --enable-cgi --disable-cli"

	if use fastcgi; then
		myconf="${myconf} --enable-fastcgi"
	fi

	if use force-cgi-redirect; then
		myconf="${myconf} --enable-force-cgi-redirect"
	fi

	php-sapi_src_compile
}

src_install() {
	PHP_INSTALLTARGETS="install"
	php-sapi_src_install

	# rename binary
	newbin "${S}/sapi/cgi/php" php-cgi
}

pkg_postinst() {
	php-sapi_pkg_postinst
	einfo "This is a CGI only build."
}
