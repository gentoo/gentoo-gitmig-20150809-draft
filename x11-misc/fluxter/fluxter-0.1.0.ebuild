# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

S=${WORKDIR}/${P}
DESCRIPTION="Fluxter is a workspace pager dockapp, particularly useful with the Fluxbox window manager."
SRC_URI="http://www.isomedia.com/homes/stevencooper/files/${P}.tar.gz"
HOMEPAGE="http://www.isomedia.com/homes/stevencooper/"
IUSE=""

DEPEND="virtual/blackbox"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

myconf="--datadir=/usr/share/commonbox"

src_compile() {

	econf ${myconf} || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README COPYING AUTHORS ChangeLog NEWS README TODO
}
