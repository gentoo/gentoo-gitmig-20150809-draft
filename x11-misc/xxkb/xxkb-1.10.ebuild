# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xxkb/xxkb-1.10.ebuild,v 1.1 2003/05/15 09:00:46 phosphan Exp $

DESCRIPTION="eXtended XKB - assign different keymaps to different windows"
HOMEPAGE="http://www.tsu.ru/~pascal/other/xxkb/"
SRC_URI="http://www.tsu.ru/~pascal/other/xxkb/xxkb-1.10.tgz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/x11"

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
