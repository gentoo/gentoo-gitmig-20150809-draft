# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.3.11-r5.ebuild,v 1.2 2005/11/04 19:01:16 gustavoz Exp $

PHPSAPI="cgi"
inherit php-sapi eutils

DESCRIPTION="PHP CGI"
SLOT="0"
IUSE="force-cgi-redirect"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc sparc ~x86"

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

	# patch to fix pspell extension, bug #99312 (new patch by upstream)
	use spell && epatch "${FILESDIR}/php4.3.11-pspell-ext-segf.patch"

	# patch to fix safe_mode bypass in GD extension, bug #109669
	if use gd || use gd-external ; then
		epatch "${FILESDIR}/php4.3.11-gd_safe_mode.patch"
	fi

	# patch fo fix safe_mode bypass in CURL extension, bug #111032
	use curl && epatch "${FILESDIR}/php4.3.11-curl_safemode.patch"

	# patch $GLOBALS overwrite vulnerability, bug #111011 and bug #111014
	epatch "${FILESDIR}/php4.3.11-globals_overwrite.patch"

	# patch phpinfo() XSS vulnerability, bug #111015
	epatch "${FILESDIR}/php4.3.11-phpinfo_xss.patch"

	# patch open_basedir directory bypass, bug #102943
	epatch "${FILESDIR}/php4.3.11-fopen_wrappers.patch"

	# patch to fix session.save_path segfault and other issues in
	# the apache2handler SAPI, bug #107602
	epatch "${FILESDIR}/php4.3.11-session_save_path-segf.patch"

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
