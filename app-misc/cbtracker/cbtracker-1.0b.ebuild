# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cbtracker/cbtracker-1.0b.ebuild,v 1.1 2004/03/28 03:17:40 zul Exp $

DESCRIPTION="CheckBook Tracker finance manager"
HOMEPAGE="http://tony.maro.net/mod.php?mod=userpage&page_id=4"
SRC_URI="http://tony.maro.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
		virtual/x11"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {

	dobin cbtracker
	dohtml ${S}/help/*
	dodir /usr/share/icons
	mv ${S}/cbt_icon.xpm ${D}/usr/share/icons/
	dodoc README

}

