# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-core/php-core-4.3.4-r2.ebuild,v 1.2 2004/01/08 06:42:01 robbat2 Exp $

PHPSAPI="cli"
inherit php-2 eutils

IUSE="${IUSE} readline"
DESCRIPTION="PHP core package"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND_EXTRA="readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	ncurses? ( >=sys-libs/ncurses-5.1 )
	>=virtual/php-4.3.4
	~virtual/php-${PV}"
DEPEND="${DEPEND} ${DEPEND_EXTRA}"
RDEPEND="${RDEPEND} ${DEPEND_EXTRA}"

src_compile() {
	if has_version 'dev-php/php' && [ -x '/usr/bin/php' ]; then
		# Ok, so we can cheat and not have to build all of it...
		cp /usr/bin/php ${S}/sapi/cli/php
		PHP_SKIP_MAKE=1
		einfo "You have dev-php/php installed, so we're cheating and using it"
		einfo "instead of rebuilding the CLI SAPI to make PEAR packages."
		einfo "configure will still be run to build the required Makefiles."
	else
		ewarn "Since you don't have dev-php/php installed, we need to build"
		ewarn "the PHP CLI interpreter to make the PEAR packages."
	fi

	# the rest of this should be identical to dev-php/php
	myconf="${myconf} `use_with readline readline /usr`"
	# Readline and Ncurses are CLI PHP only
	# readline needs ncurses
	use ncurses || use readline \
		&& myconf="${myconf} --with-ncurses=/usr" \
		|| myconf="${myconf} --without-ncurses"

	myconf="${myconf} \
		--disable-cgi \
		--enable-cli"

	php_src_compile
}


src_install() {
	# make sure the possibly faked PHP is in place and new enough to avoid build storms
	touch ${S}/sapi/cli/php
	PHP_INSTALLTARGETS="install-programs install-pear install-build install-headers"
	PHP_SKIP_BUILD=1
	php_src_install
	#rm -rf ${D}/etc/php4 ${D}/etc/php
}

pkg_postinst() {
	einfo "This is a limited build to provide PEAR and build utilities"
	einfo
	pear config-set cache_dir /tmp/pear/cache
	einfo "The PEAR cache dir was set to /tmp/pear/cache, run:"
	einfo "pear config-set cache_dir <your_dir_of_choice>"
	einfo "if you wish to change it."
}

pkg_preinst() {
	#php_pkg_preinst
	:
}
