# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-1.0.0.ebuild,v 1.2 2005/02/17 23:29:03 hansmi Exp $

inherit eutils

DESCRIPTION="gerbv - The gEDA Gerber Viewer"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.geda.seul.org"

IUSE="doc gtk2 png xinerama"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1* )
	png? ( media-libs/libpng )
	png? ( media-libs/gdk-pixbuf )
	virtual/x11"

src_compile() {
	local confOptions

	use gtk2 && confOptions='--enable-gtk2'
	use gtk2 && use xinerama && epatch ${FILESDIR}/${P}-Xinerama.patch
	use png || confOptions="$confOptions --disable-exportpng"

	econf $confOptions || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	if use doc; then
		cd doc
		dodoc sources.txt
		use png && dodoc PNG-print/PNGPrintMiniHowto.txt
		docinto eagle
		dodoc eagle/eagle2exc*
	fi
}
