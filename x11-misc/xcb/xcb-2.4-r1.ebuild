# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcb/xcb-2.4-r1.ebuild,v 1.1 2010/09/17 01:43:34 jer Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Marc Lehmann's improved X Cut Buffers"
HOMEPAGE="http://www.goof.com/pcg/marc/xcb.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="motif"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	motif? ( x11-libs/openmotif )"

src_compile() {
	local gui libs

	if use motif; then
		gui="-DMOTIF"
		libs="-lXm -lXt -lX11"
	else
		gui="-DATHENA"
		libs="-lXaw -lXt -lXext -lX11"
	fi

	emake -f Makefile.std xcb Xcb.ad \
		CC=$(tc-getCC) \
		CPP=$(tc-getCPP) \
		CFLAGS="${CFLAGS} ${gui}" \
		GUI="${gui}" \
		LIBS="${libs}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin xcb || die "dobin failed"
	newman xcb.man xcb.1
	insinto /usr/share/X11/app-defaults
	newins Xcb.ad Xcb || die "newins failed"
}
