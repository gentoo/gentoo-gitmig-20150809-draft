# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.4-r2.ebuild,v 1.2 2004/11/01 20:35:49 corsair Exp $

inherit eutils

MY_P=${PN}.${PV}
S=${WORKDIR}/${MY_P}
SHAPE_P=shape-patch.${PV}-shape-1.1

DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz
	http://www.ctan.org/tex-archive/graphics/transfig-shapepatch/${SHAPE_P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64"
IUSE=""

DEPEND="virtual/x11
	x11-libs/Xaw3d
	media-libs/jpeg
	media-libs/libpng"
RDEPEND="${DEPEND}
	media-gfx/transfig
	media-libs/netpbm"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-xaw3d.diff
	epatch ../${SHAPE_P}/${PN}.${SHAPE_P#*.}.patch	# bug #20877
}

src_compile() {
	xmkmf || die
	make BINDIR=/usr/bin XFIGLIBDIR=/usr/lib/xfig || die
}

src_install() {

	make \
		DESTDIR=${D} \
		BINDIR=/usr/bin \
		XFIGLIBDIR=/usr/lib/xfig \
		MANDIR=/usr/share/man/man1 \
		MANSUFFIX=1 \
		install install.all || die

	mv ${D}/usr/share/doc/{${P},${PF}}
	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
	dodoc ../${SHAPE_P}/shapepatch.README
}
