# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Pedro Fiol <fiocolpe@softhome.net>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iv/iv-0.1.9.ebuild,v 1.2 2002/05/17 04:44:13 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This is an image viewer"

SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/iv-0.1.9.tar.bz2"
HOMEPAGE="http://wolfpack.twu.net"
LICENSE="GPL-2"
DEPEND=">=media-libs/imlib-1.9.13
		>=x11-libs/gtk+-1.2.10"
RDEPEND="${DEPEND}"

src_compile() {
	cd iv
	emake || die
}

src_install () {
	dobin iv/iv
	dodir /usr/share/icons
	insinto /usr/share/icons
	doins iv/images/iv.xpm
	doman iv/iv.1
	dodoc LICENSE README
}
