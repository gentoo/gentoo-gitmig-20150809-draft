# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/transfig/transfig-3.2.4-r1.ebuild,v 1.13 2004/11/01 20:18:50 corsair Exp $

inherit gcc eutils

MY_P=${P/transfig-/transfig.}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A set of tools for creating TeX documents with graphics which can be printed in a wide variety of environments"
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.tar.gz"
HOMEPAGE="http://www.xfig.org"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~ppc64"
IUSE=""

DEPEND="virtual/x11
	>=media-libs/jpeg-6
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
	#bad way to fix a bad issue
	if [ "$(gcc-major-version)" -eq "3" -a "$(gcc-minor-version)" -ge "3" ]
	then
	epatch  ${FILESDIR}/${P}-gcc-3.3.patch
	fi
}

src_compile() {
	xmkmf || die
	make Makefiles || die

	emake || die
}

src_install() {
	# gotta set up the dirs for it....
	dodir /usr/bin
	dodir /usr/sbin
	dodir /usr/share/man/man1
	dodir /usr/X11R6/lib/fig2dev

	#Now install it.
	make \
		DESTDIR=${D} \
		install || die

	#Install docs
	dodoc README CHANGES LATEX.AND.XFIG NOTES
	doman doc/fig2dev.1
	doman doc/fig2ps2tex.1
	doman doc/pic2tpic.1
}
