# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vncrec/vncrec-0.2.ebuild,v 1.4 2004/07/14 06:39:34 mr_bones_ Exp $

DESCRIPTION="VNC session recorder and player"
HOMEPAGE="http://www.sodan.org/~penny/vncrec/"
SRC_URI="http://www.sodan.org/~penny/vncrec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	touch vncrec/vncrec.man
	xmkmf || die
	emake \
		CDEBUGFLAGS="${CFLAGS}" \
		CXXDEBUGFLAGS="${CXXFLAGS}" \
		World || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README README.vnc
}
