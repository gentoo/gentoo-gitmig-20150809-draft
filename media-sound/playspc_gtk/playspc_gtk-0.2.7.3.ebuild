# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/playspc_gtk/playspc_gtk-0.2.7.3.ebuild,v 1.4 2004/04/08 07:54:33 eradicator Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Playspc_gtk is a gtk program utilizing the SNeSe SPC core to play SPC files.  RAR support is well integrated."
SRC_URI="mirror://sourceforge/playspc/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://playspc.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-arch/rar
	=x11-libs/gtk+-1.2*"

src_compile() {
	cd ${S}
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	exeinto /usr/bin
	dolib.so libopenspc/libopenspc.so
	doexe playspc_gtk spccore
	dodoc CHANGELOG COPYING TODO README
}


