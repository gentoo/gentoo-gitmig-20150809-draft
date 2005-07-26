# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xxkb/xxkb-1.10.ebuild,v 1.10 2005/07/26 15:16:23 dholm Exp $

inherit eutils

DESCRIPTION="eXtended XKB - assign different keymaps to different windows"
HOMEPAGE="http://sourceforge.net/projects/xxkb/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
DEPEND="virtual/x11"
IUSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34-fix.patch
}

src_compile() {
	xmkmf || die
	emake PROJECTROOT=/usr PIXMAPDIR=/usr/share/xxkb || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/xxkb

	exeinto /usr/bin
	doexe xxkb

	insinto /usr/share/xxkb
	doins *.xpm
	doins ${FILESDIR}/*.xpm

	insinto /etc/X11/app-defaults
	mv XXkb.ad XXkb
	doins XXkb

	dodoc README-Linux.koi8 README.koi8 CHANGES.koi8  ${FILESDIR}/README
	mv xxkb.man xxkb.man.1
	doman xxkb.man.1
}
