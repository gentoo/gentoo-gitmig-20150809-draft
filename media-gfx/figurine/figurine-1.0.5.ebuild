# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/figurine/figurine-1.0.5.ebuild,v 1.3 2003/07/12 16:44:48 aliz Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A vector based graphics editor similar to xfig, but simpler"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/figurine/${P}.tar.gz"
HOMEPAGE="http://figurine.sourceforge.net/"

DEPEND=" >=media-gfx/transfig-3.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf || die "econf failed"

	emake || die "make failed"
}

src_install () {

	einstall || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README
}

