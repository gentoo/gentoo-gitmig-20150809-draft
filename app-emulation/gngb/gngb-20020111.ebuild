# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="gngb - Gameboy / Gameboy Color emulator"
HOMEPAGE="http://members.lycos.fr/frogus/gngb/"
LICENSE="GPL"
RDEPEND="media-libs/libsdl
        opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}"
SRC_URI="http://membres.lycos.fr/frogus/gngb/download/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	use opengl || myconf=" --with-gl "
	./configure ${myconf}\
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install () {
	dodoc NEWS README TODO INSTALL AUTHORS
	make DESTDIR=${D} install || die
}
