# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-0.16-r1.ebuild,v 1.2 2006/01/22 15:51:29 plasmaroo Exp $

DESCRIPTION="gerbv - The gEDA Gerber Viewer"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.geda.seul.org"

IUSE="doc png"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-libs/glibc-2.1.3
	=x11-libs/gtk+-2*
	png? ( media-libs/libpng
		media-libs/gdk-pixbuf )"

src_compile() {
	local confOptions
	confOptions='--enable-gtk2'
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
