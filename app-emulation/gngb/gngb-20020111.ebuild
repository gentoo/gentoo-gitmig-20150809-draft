# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gngb/gngb-20020111.ebuild,v 1.5 2002/09/03 15:00:07 seemant Exp $

DESCRIPTION="gngb - Gameboy / Gameboy Color emulator"
HOMEPAGE="http://membres.lycos.fr/frogus/gngb/"
LICENSE="GPL"
KEYWORDS="x86 -ppc"
SLOT="0"    
RDEPEND="media-libs/libsdl
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}"
SRC_URI="http://membres.lycos.fr/frogus/gngb/download/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	use opengl || myconf=" --with-gl "

	econf ${myconf} || die
	
	emake || die
}

src_install () {
	dodoc NEWS README TODO INSTALL AUTHORS
	make DESTDIR=${D} install || die
}
