# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmmsctrl/xmmsctrl-1.6-r1.ebuild,v 1.4 2004/03/27 03:41:27 eradicator Exp $

inherit eutils

DESCRIPTION="A small program to control xmms from a shell script."
SRC_URI="http://www.docs.uu.se/~adavid/utils/${P}.tar.gz"
HOMEPAGE="http://user.it.uu.se/~adavid/utils/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

USE=""

RDEPEND=">=media-sound/xmms-1.2.7-r16"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.48"

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

	docinto samples
	dodoc samples/*
}
