# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.5_alpha5.ebuild,v 1.3 2006/12/02 00:30:11 masterdriverz Exp $

inherit eutils

MY_P="${PN}.${PV/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://xfig.org"
SRC_URI="http://xfig.org/software/${PN}/${PV/_/-}/${MY_P}.full.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-xaw3d.diff"
}

src_compile() {
	xmkmf || die
	make BINDIR=/usr/bin XFIGLIBDIR=/usr/lib/xfig || die
}

src_install() {

	emake \
		DESTDIR="${D}" \
		BINDIR=/usr/bin \
		XFIGLIBDIR=/usr/lib/xfig \
		MANDIR=/usr/share/man/man1 \
		MANSUFFIX=1 \
		install install.all || die

	mv "${D}"/usr/share/doc/{${P},${PF}}
	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
	dodoc ../${SHAPE_P}/shapepatch.README
}
