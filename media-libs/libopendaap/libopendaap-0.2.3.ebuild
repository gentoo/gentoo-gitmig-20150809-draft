# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopendaap/libopendaap-0.2.3.ebuild,v 1.3 2004/08/30 15:44:33 dholm Exp $

SLOT="0"
LICENSE="crazney APSL-2"
KEYWORDS="~x86 ~ppc"
DESCRIPTION="libopendaap is a library which enables applications to discover and connect to iTunes(R) music shares"
SRC_URI="http://crazney.net/programs/itunes/files/${P}.tar.bz2"
HOMEPAGE="http://crazney.net/programs/itunes/libopendaap.html"
IUSE=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	einstall || die
}
