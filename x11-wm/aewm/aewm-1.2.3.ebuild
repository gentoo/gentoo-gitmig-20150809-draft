# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm/aewm-1.2.3.ebuild,v 1.8 2005/06/30 17:50:47 josejx Exp $

inherit eutils

IUSE="gtk2"

DESCRIPTION="A minimalistic X11 window manager."
HOMEPAGE="http://www.red-bean.com/%7Edecklin/aewm/"
SRC_URI="http://www.red-bean.com/%7Edecklin/aewm/${P}.tar.gz"
LICENSE="aewm"
SLOT="0"
KEYWORDS="ppc x86"
DEPEND="virtual/x11
	gtk2? ( >=x11-libs/gtk+-2.0.0 ) !gtk2? ( =x11-libs/gtk+-1.2* )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-freetype-gentoo.diff || die
	use gtk2 || sed -ie 's/#USE_OLD_GTK/USE_OLD_GTK/' clients/Makefile
	sed -ie 's/lucidasans-10/-adobe-helvetica-bold-r-normal--*-120-*-*-*-*-*-*/' \
		src/aewmrc.sample
}

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make DESTDIR=${D} XROOT=/usr MANDIR=${D}/usr/share/man/man1 install || die
	dodoc ChangeLog README LICENSE
}

pkg_postinst() {
	einfo "See /usr/share/doc/${P}/README.gz for some delicious ~/.xinitrc recipes"
}
