# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.30.ebuild,v 1.3 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://ftp1.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtkDPS-0.3.3
	>=x11-libs/gtk+-1.2.10-r4"

RDEPEND=${DEPEND}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README 
}
