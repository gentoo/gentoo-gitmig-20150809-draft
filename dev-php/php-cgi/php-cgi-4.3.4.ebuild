# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-4.3.4.ebuild,v 1.2 2004/01/08 04:16:21 robbat2 Exp $

PHPSAPI="cgi"
inherit php-2 eutils

IUSE="${IUSE} readline"

DESCRIPTION="PHP CGI"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~mips"

DEPEND_EXTRA="readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	ncurses? ( >=sys-libs/ncurses-5.1 )"
DEPEND="${DEPEND} ${DEPEND_EXTRA}"
RDEPEND="${RDEPEND} ${DEPEND_EXTRA}"
PDEPEND="${PDEPEND} ~dev-php/php-core-${PV}"
PROVIDE="virtual/php-4.3.4"


src_compile() {
	myconf="${myconf} `use_with readline readline /usr`"
	# Readline and Ncurses are CLI PHP only
	# readline needs ncurses
	use ncurses || use readline \
		&& myconf="${myconf} --with-ncurses=/usr" \
		|| myconf="${myconf} --without-ncurses"

	# CLI needed to build stuff
	myconf="${myconf} \
		--enable-cgi \
		--enable-cli \
		--enable-fastcgi"

	php_src_compile
}


src_install() {
	installtargets="${installtargets} install-cgi install-sapi"
	php_src_install

	# php executable is located in ./sapi/cli/
	exeinto /usr/bin
	newexe sapi/cgi/php php-cgi
}

pkg_postinst() {
	php_pkg_postinst
	einfo "This is a CGI only build."
}
pkg_preinst() {
	php_pkg_preinst
}
