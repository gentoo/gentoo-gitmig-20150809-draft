# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcb/xcb-2.4.ebuild,v 1.10 2006/09/08 22:36:27 dang Exp $

DESCRIPTION="Marc Lehmann's improved X Cut Buffers"
HOMEPAGE="http://www.goof.com/pcg/marc/xcb.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="motif"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXaw
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )
	motif? ( x11-libs/openmotif )"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv xcb.man xcb.1 || die 'mv failed'
}

src_compile() {
	local gui libs

	if use motif; then
		gui="-DMOTIF"
		libs="-L/usr/X11R6/lib -lXm -lXt -lX11"
	else
		gui="-DATHENA"
		libs="-L/usr/X11R6/lib -lXaw -lXt -lXext -lX11"
	fi

	emake -f Makefile.std xcb Xcb.ad \
		CFLAGS="${CFLAGS} ${gui} -I/usr/X11R6/include" \
		GUI="${gui}" \
		LIBS="${libs}" \
		|| die 'emake failed'
}

src_install() {
	dobin xcb
	doman xcb.1
	insinto /usr/X11R6/lib/X11/app-defaults ; newins Xcb.ad Xcb
}
