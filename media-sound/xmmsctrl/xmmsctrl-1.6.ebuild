# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmmsctrl/xmmsctrl-1.6.ebuild,v 1.3 2003/04/28 21:14:33 pylon Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small program to control xmms from a shell script."
SRC_URI="http://www.docs.uu.se/~adavid/utils/${P}.tar.gz"
HOMEPAGE="http://user.it.uu.se/~adavid/utils/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-sound/xmms-1.2.7-r16"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	patch -p1 <${FILESDIR}/xmmsctrl-jump.patch || die
}

src_compile() {
	emake || die
}

src_install () {
	dobin xmmsctrl
	dodoc README HELP
	mv samples ${D}/usr/share/doc/${PF}/
	prepalldocs	
}
