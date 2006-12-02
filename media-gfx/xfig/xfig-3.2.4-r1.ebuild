# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.4-r1.ebuild,v 1.12 2006/12/02 00:30:11 masterdriverz Exp $

inherit eutils

MY_P=${PN}.${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~hppa amd64 ~ppc64"
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
			x11-proto/inputproto )
		virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-xaw3d.diff
}

src_compile() {
	xmkmf || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die

	emake \
		DESTDIR=${D} \
		MANDIR=/usr/share/man/man1 \
		MANSUFFIX=1 \
		install.all || die

	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
}
