# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.8.0.ebuild,v 1.1 2003/08/10 05:29:56 jje Exp $

DESCRIPTION="mpc is a client for Music Player Daemon (mpd)"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"
HOMEPAGE="http://musicpd.sourceforge.net/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND=">=media-sound/mpd-0.8.2"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"

	econf ${myconf} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	dobin mpc
	doman mpc.1
	dodoc AUTHORS COPYING INSTALL README
}

