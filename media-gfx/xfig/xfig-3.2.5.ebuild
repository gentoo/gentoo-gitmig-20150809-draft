# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.5.ebuild,v 1.1 2007/04/01 12:23:08 bangert Exp $

inherit eutils multilib

MY_P=${PN}.${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libXaw
				x11-libs/libXp )
			virtual/x11 )
	x11-libs/Xaw3d
	media-libs/jpeg
	media-libs/libpng
	media-gfx/transfig
	media-libs/netpbm"
DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake
			app-text/rman
			x11-proto/xproto
			x11-proto/inputproto
			x11-libs/libXi )
		virtual/x11 )"

src_compile() {
	xmkmf || die
	emake BINDIR=/usr/bin XFIGLIBDIR=/usr/$(get_libdir)/xfig || die
}

src_install() {

	emake -j1 \
		DESTDIR=${D} \
		BINDIR=/usr/bin \
		XFIGLIBDIR=/usr/$(get_libdir)/xfig \
		MANDIR=/usr/share/man/man1 \
		MANSUFFIX=1 \
		install install.all || die

	insinto /usr/share/doc/${P}
	doins README FIGAPPS CHANGES LATEX.AND.XFIG
}
