# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.4.0-r1.ebuild,v 1.9 2005/10/29 22:16:13 chtekk Exp $

PHPSAPI="cli"
inherit php-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

# fixed PCRE library for security issues, bug #102373
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-pcrelib-new-secpatch.tar.bz2"

src_unpack() {
	php-sapi_src_unpack
	[ "${ARCH}" == "amd64" ] && epatch "${FILESDIR}/php-4.3.4-amd64hack.diff"

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
