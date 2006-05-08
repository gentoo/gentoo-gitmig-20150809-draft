# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopendaap/libopendaap-0.4.0.ebuild,v 1.9 2006/05/08 20:12:34 corsair Exp $

IUSE=""

inherit eutils

DESCRIPTION="libopendaap is a library which enables applications to discover and connect to iTunes(R) music shares"
SRC_URI="http://crazney.net/programs/itunes/files/${P}.tar.bz2"
HOMEPAGE="http://crazney.net/programs/itunes/libopendaap.html"
SLOT="0"
LICENSE="crazney APSL-2"
KEYWORDS="~alpha amd64 ppc ~ppc64 sparc x86"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
