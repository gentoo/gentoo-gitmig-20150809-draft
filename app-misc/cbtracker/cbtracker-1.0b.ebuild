# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cbtracker/cbtracker-1.0b.ebuild,v 1.6 2006/03/19 00:02:00 joshuabaergen Exp $

DESCRIPTION="CheckBook Tracker finance manager"
HOMEPAGE="http://tony.maro.net/mod.php?mod=userpage&page_id=4"
SRC_URI="http://tony.maro.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	|| ( x11-libs/libXi virtual/x11 )"
DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin cbtracker || die
	dohtml ${S}/help/*
	dodir /usr/share/icons
	mv ${S}/cbt_icon.xpm ${D}/usr/share/icons/
	dodoc README
}
