# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopendaap/libopendaap-0.3.0.ebuild,v 1.2 2005/01/23 23:44:41 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="libopendaap is a library which enables applications to discover and connect to iTunes(R) music shares"
SRC_URI="http://crazney.net/programs/itunes/files/${P}.tar.bz2"
HOMEPAGE="http://crazney.net/programs/itunes/libopendaap.html"
SLOT="0"
LICENSE="crazney APSL-2"
KEYWORDS="~amd64 ~x86 ~ppc"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-types.h
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
