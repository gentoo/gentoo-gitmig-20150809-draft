# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.1.6.ebuild,v 1.3 2003/02/13 13:15:45 vapier Exp $

DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://www.mikmod.org/"
LICENSE="GPL-2"
SRC_URI="http://www.mikmod.org/files/mikmod/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND="libmikmod"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	econf || die
        	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
