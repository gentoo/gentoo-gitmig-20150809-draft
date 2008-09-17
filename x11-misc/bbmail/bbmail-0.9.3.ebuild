# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbmail/bbmail-0.9.3.ebuild,v 1.1 2008/09/17 21:16:31 coldwind Exp $

inherit eutils

DESCRIPTION="blackbox mail notification"
HOMEPAGE="http://www.sourceforge.net/projects/bbtools"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	virtual/blackbox
	x11-libs/libX11
	x11-libs/libXext"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin scripts/bbmailparsefm.pl
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
