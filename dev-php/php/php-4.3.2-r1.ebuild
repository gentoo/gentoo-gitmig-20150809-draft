# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.3.2-r1.ebuild,v 1.3 2004/01/08 04:13:44 robbat2 Exp $

PHPSAPI="cli"
inherit php eutils

IUSE="${IUSE} readline"

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~mips"

DEPEND="${DEPEND}
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 ) "

RDEPEND="${RDEPEND}"

EXCLUDE_DB4_FIX=1
EXCLUDE_PEAR_FIX=1

src_compile() {

	use readline && myconf="${myconf} --with-readline"

	myconf="${myconf} \
		--disable-cgi \
		--enable-cli"

	php_src_compile

}


src_install() {
	installtargets="${installtargets} install-cli"
	php_src_install

	# php executable is located in ./sapi/cli/
	exeinto /usr/bin
	doexe sapi/cli/php
}

pkg_postinst() {
	php_pkg_postinst
	einfo "This is a CLI only build."
	einfo "You can not use it on a webserver."
}
pkg_preinst() {
	php_pkg_preinst
}
