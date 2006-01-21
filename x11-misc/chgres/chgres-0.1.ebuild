# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/chgres/chgres-0.1.ebuild,v 1.8 2006/01/21 10:48:11 nelchael Exp $

IUSE=""
DESCRIPTION="A very simple command line utility for changing X resolutions"
HOMEPAGE="http://hpwww.ec-lyon.fr/~vincent/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

SRC_URI="http://hpwww.ec-lyon.fr/~vincent/${P}.tar.gz"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXxf86dga
		x11-libs/libXext
		x11-libs/libXxf86vm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xf86vidmodeproto
		x11-proto/xf86dgaproto )
	virtual/x11 )"

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe chgres
	dodoc README
}
