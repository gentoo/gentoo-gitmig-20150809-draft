# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/agqt/agqt-0.10.ebuild,v 1.1 2002/04/27 02:57:42 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="6's spiffy AudioGalaxy Query Tool"
SRC_URI="http://prdownloads.sourceforge.net/agqt/${P}.tar.bz2"
HOMEPAGE="http://agqt.sourceforge.net"

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
