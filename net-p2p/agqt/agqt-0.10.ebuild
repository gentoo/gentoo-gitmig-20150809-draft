# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/agqt/agqt-0.10.ebuild,v 1.2 2002/06/25 11:12:27 bangert Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="6's spiffy AudioGalaxy Query Tool"
SRC_URI="mirror://sourceforge/agqt/${P}.tar.bz2"
HOMEPAGE="http://agqt.sourceforge.net"
SLOT="0"

DEPEND="net-misc/openag
	tcltk? ( dev-lang/tcl
		dev-lang/tk )"


src_compile() {

	make clean
	make
}

src_install() {

	dobin ag am
	use tcltk && dobin agqt.tcl

	dodoc README agrc.sample
}
