# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.8.1.ebuild,v 1.1 2003/08/14 04:33:47 g2boojum Exp $

IUSE=""

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"
HOMEPAGE="http://www.musicpd.org"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"

	econf ${myconf} || die "could not configure"

	emake || die "emake failed"
}

src_install() {
	dobin mpc

	doman mpc.1

	dodoc AUTHORS COPYING INSTALL README
}

