# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.50.1.ebuild,v 1.1 2002/09/03 10:48:03 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/${P}.tar.gz"
HOMEPAGE="http://aspell.net/"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

#
# These flags a reset here because too much optimisation can cause aspell's
# compilation process to break.  Moreover, these must be set before ./configure
# otherwise it breaks again.  A very fragile build process, really.
#
#CXXFLAGS="-O2"
#CFLAGS=${CXXFLAGS}

src_compile() {
	elibtoolize

	econf \
		--disable-static \
		--sysconfdir=/etc/aspell \
		--enable-docdir=/usr/share/doc/${PF} || die
	
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	dohtml -r man-html
	rm -rf man-html
	docinto text
	dodoc man-text
	rm -rf man-text
	cd ${S}
	
	dodoc README* TODO

	cd examples
	make clean || die
	cd ${S}
	
	docinto examples
	dodoc examples/*

}

pkg_postinst() {

	einfo "You will need to install a dictionary now.  Please choose an"
	einfo "aspell-<LANG> dictionary from the app-i18n category"
	einfo "After installing an aspell dictionary for your language(s),"
	einfo "You may use the aspell-import utility to import your personal"
	einfo "dictionaries from ispell, pspell and the older aspell"
}
