# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftcurs/giftcurs-0.6.1-r1.ebuild,v 1.1 2004/01/07 01:24:38 spider Exp $

MY_P="giFTcurs-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A ncurses frontend to the giFT (OpenFT) daemon"
SRC_URI="http://savannah.nongnu.org/download/${PN}/giFTcurs.pkg/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/giftcurs/"
SLOT="0"
LICENSE="GPL-2"
IUSE="gpm nls"
KEYWORDS="x86 ~sparc ~ppc"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=dev-libs/glib-2.0"

RDEPEND="${DEPEND}
	net-p2p/gift"

src_compile() {
	local myconf=""

	use gpm || myconf="${myconf} --disable-mouse --disable-libgpm"
	use nls || myconf="${myconf} --disable-nls"

	econf $myconf || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}
