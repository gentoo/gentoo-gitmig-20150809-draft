# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmmsctrl/xmmsctrl-1.9.ebuild,v 1.1 2005/10/16 21:28:13 metalgod Exp $

IUSE=""

inherit eutils bash-completion

DESCRIPTION="A small program to control xmms from a shell script."
SRC_URI="http://www.cs.aau.dk/~adavid/utils/${P}.tar.gz"
HOMEPAGE="http://www.cs.aau.dk/~adavid/utils/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.8-jump.patch
}

src_compile() {
	emake || die
}

src_install () {
	dobin xmmsctrl
	dodoc README HELP

	docinto samples
	dodoc samples/*

	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}
