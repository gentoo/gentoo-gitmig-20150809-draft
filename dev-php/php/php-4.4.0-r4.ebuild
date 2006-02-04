# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.4.0-r4.ebuild,v 1.8 2006/02/04 17:45:00 agriffis Exp $

PHPSAPI="cli"
inherit php-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sparc x86"
IUSE=""

# fixed PCRE library for security issues, bug #102373
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-pcrelib-new-secpatch.tar.bz2"

src_unpack() {
	php-sapi_src_unpack
	[ "${ARCH}" == "amd64" ] && epatch "${FILESDIR}/php-4.3.4-amd64hack.diff"

	# fix imap symlink creation, bug #105351
	use imap && epatch "${FILESDIR}/php4.4.0-imap-symlink.diff"

	# patch to fix pspell extension, bug #99312 (new patch by upstream)
	use spell && epatch "${FILESDIR}/php4.4.0-pspell-ext-segf.patch"

	# patch to fix safe_mode bypass in GD extension, bug #109669
	if use gd || use gd-external ; then
		epatch "${FILESDIR}/php4.4.0-gd_safe_mode.patch"
	fi

	# patch fo fix safe_mode bypass in CURL extension, bug #111032
	use curl && epatch "${FILESDIR}/php4.4.0-curl_safemode.patch"

	# patch $GLOBALS overwrite vulnerability, bug #111011 and bug #111014
	epatch "${FILESDIR}/php4.4.0-globals_overwrite.patch"

	# patch phpinfo() XSS vulnerability, bug #111015
	epatch "${FILESDIR}/php4.4.0-phpinfo_xss.patch"

	# patch open_basedir directory bypass, bug #102943
	epatch "${FILESDIR}/php4.4.0-fopen_wrappers.patch"

	# patch to fix session.save_path segfault and other issues in
	# the apache2handler SAPI, bug #107602
	epatch "${FILESDIR}/php4.4.0-session_save_path-segf.patch"

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
