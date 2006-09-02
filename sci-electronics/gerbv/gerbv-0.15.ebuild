# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-0.15.ebuild,v 1.5 2006/09/02 21:15:53 calchan Exp $

DESCRIPTION="gerbv - The gEDA Gerber Viewer"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.geda.seul.org"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha sparc"

DEPEND="dev-util/guile
	=x11-libs/gtk+-1*
	media-libs/gdk-pixbuf"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS CONTRIBUTORS COPYING ChangeLog NEWS README
}
