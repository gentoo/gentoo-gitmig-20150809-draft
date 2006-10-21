# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnow/xsnow-1.42.ebuild,v 1.19 2006/10/21 21:40:00 omp Exp $

DESCRIPTION="snow, reindeer, and santa on the root window"
SRC_URI="http://www.euronet.nl/~rja/Xsnow/${P}.tar.gz"
HOMEPAGE="http://www.euronet.nl/~rja/Xsnow/"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
LICENSE="as-is"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-misc/gccmakedep
	x11-proto/xextproto
	x11-proto/xproto"

src_compile() {
	xmkmf || die
	make depend || die
	emake || die
}

src_install () {
	into /usr
	dobin xsnow || die
	rman -f HTML < xsnow._man > xsnow.1-html && \
		mv -f xsnow.1-html xsnow.1.html && \
		mv -f xsnow._man xsnow.1
	doman xsnow.1
	dodoc xsnow.1.html README
}
