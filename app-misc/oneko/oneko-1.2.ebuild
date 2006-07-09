# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/oneko/oneko-1.2.ebuild,v 1.17 2006/07/09 11:52:35 nelchael Exp $

DESCRIPTION="A cat (or dog) which chases the mouse around the screen"
HOMEPAGE="http://agtoys.sourceforge.net"
SRC_URI="http://agtoys.sourceforge.net/oneko/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/gccmakedep
		x11-misc/imake
		app-text/rman
		x11-proto/xextproto )
	virtual/x11 )"

src_compile() {
	xmkmf -a || die
	emake || die
}

src_install() {
	into /usr
	dobin oneko
	mv oneko._man oneko.1x
	doman oneko.1x
	dodoc oneko.1x.html oneko.1.html README README-NEW
}
