# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwave/wmwave-0.4.ebuild,v 1.2 2004/03/26 23:10:15 aliz Exp $

IUSE=""
S="${WORKDIR}/wmwave"
KEYWORDS="~ppc ~x86"
DESCRIPTION="wmwave is a windom manager dockapp which displays the quality, link, level and noise of an iee802.11 (wavelan) link."
SRC_URI="http://www.schuermann.org/~dockapps/dist/wmwave-0-4.tgz"
HOMEPAGE="http://www.schuermann.org/~dockapps"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"

src_unpack() {
	unpack "wmwave-0-4.tgz"
	cd "${S}"
}

src_compile() {
	emake || die
}

src_install () {
	dobin wmwave
	doman wmwave.1
	dodoc COPYING README
}
