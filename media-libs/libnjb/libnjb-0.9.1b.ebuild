# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-0.9.1b.ebuild,v 1.5 2004/04/27 21:57:56 agriffis Exp $

inherit eutils

DESCRIPTION="libnjb is a C library and API for communicating with the Creative Nomad JukeBox digital audio player under BSD and Linux."
HOMEPAGE="http://libnjb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=dev-libs/libusb-0.1.7"
S="${WORKDIR}/libnjb"

src_compile() {

	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/libnjb-errno.patch
	./configure \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man \
	--sysconfdir=/etc \
	|| die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	prepalldocs
	dodoc FAQ LICENSE INSTALL CHANGES README
}
