# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.50.5.ebuild,v 1.5 2004/04/02 18:58:53 avenj Exp $

inherit libtool

DESCRIPTION="A spell checker replacement for ispell"
HOMEPAGE="http://aspell.net/"
SRC_URI="http://aspell.net/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64 ~ia64 s390"

DEPEND=">=sys-libs/ncurses-5.2"

pkg_setup() {
	if [ ${ARCH} = "ppc" ] ; then
		CXXFLAGS="-O2 -fsigned-char"
		CFLAGS=${CXXFLAGS}
	fi
}

src_compile() {
	elibtoolize --reverse-deps

	econf \
		--disable-static \
		--sysconfdir=/etc/aspell \
		--enable-docdir=/usr/share/doc/${PF} || die

	emake || die
}

src_install() {
	dodoc README* TODO

	make DESTDIR=${D} install || die
	mv ${D}/usr/share/doc/${PF}/man-html ${D}/usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/man-text ${D}/usr/share/doc/${PF}/text

	# install ispell/aspell compatibility scripts
	exeinto /usr/bin
	newexe scripts/ispell ispell-aspell
	newexe scripts/spell spell-aspell

	cd examples
	make clean || die
	docinto examples
	dodoc ${S}/examples/*

}

pkg_postinst() {
	einfo "You will need to install a dictionary now.  Please choose an"
	einfo "aspell-<LANG> dictionary from the app-dicts category"
	einfo "After installing an aspell dictionary for your language(s),"
	einfo "You may use the aspell-import utility to import your personal"
	einfo "dictionaries from ispell, pspell and the older aspell"
}
