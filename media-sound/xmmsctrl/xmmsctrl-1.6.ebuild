# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmmsctrl/xmmsctrl-1.6.ebuild,v 1.10 2004/09/02 18:18:28 pvdabeel Exp $

inherit eutils

DESCRIPTION="A small program to control xmms from a shell script."
SRC_URI="http://www.docs.uu.se/~adavid/utils/${P}.tar.gz"
HOMEPAGE="http://user.it.uu.se/~adavid/utils/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa"

IUSE=""

DEPEND=">=media-sound/xmms-1.2.7-r16"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/xmmsctrl-jump.patch
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
