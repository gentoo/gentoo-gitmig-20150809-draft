# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak-ss/emacspeak-ss-1.9.1.ebuild,v 1.1 2004/04/24 02:47:24 squinky86 Exp $

inherit eutils

DESCRIPTION="This adds support for several speech synthesizers to emacspeak"
HOMEPAGE="http://leb.net/blinux"
SRC_URI="http://leb.net/pub/blinux/emacspeak/blinux/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	>=app-accessibility/emacspeak-18"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gentoo-apollo-fix.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		man1dir=${D}/usr/share/man/man1 \
		install || die
	dodoc COPYING CREDITS ChangeLog INSTALL OtherSynthesizers TODO
	dodoc TROUBLESHOOTING README*
}
