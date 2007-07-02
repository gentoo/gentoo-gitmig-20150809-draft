# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/playspc_gtk/playspc_gtk-0.2.7.3.ebuild,v 1.9 2007/07/02 15:17:26 peper Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Playspc_gtk is a gtk program utilizing the SNeSe SPC core to play SPC files.  RAR support is well integrated."
SRC_URI="mirror://sourceforge/playspc/${P}.tar.gz"
RESTRICT="mirror"
HOMEPAGE="http://playspc.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
# -*: Contains x86 assembly
KEYWORDS="-* x86"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	cd ${S}
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	exeinto /usr/bin
	dolib.so libopenspc/libopenspc.so
	doexe playspc_gtk spccore
	dodoc CHANGELOG TODO README
}


