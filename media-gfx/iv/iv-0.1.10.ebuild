# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iv/iv-0.1.10.ebuild,v 1.1 2003/04/24 11:41:38 vapier Exp $

inherit eutils

DESCRIPTION="a basic image viewer"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"
HOMEPAGE="http://wolfpack.twu.net/utilities.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/imlib-1.9.13
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd ${P}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	cd iv
	emake || die
}

src_install() {
	dobin iv/iv
	dodir /usr/share/icons
	insinto /usr/share/icons
	doins iv/images/iv.xpm
	doman iv/iv.1
	dodoc LICENSE README
}
