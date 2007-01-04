# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/autocutsel/autocutsel-0.9.0.ebuild,v 1.1 2007/01/04 22:35:50 troll Exp $

DESCRIPTION="Synchronise the two copy/paste buffers mainly used by X applications"
HOMEPAGE="http://www.lepton.fr/tools/autocutsel/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXaw
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
