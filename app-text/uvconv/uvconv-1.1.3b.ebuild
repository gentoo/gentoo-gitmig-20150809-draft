# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uvconv/uvconv-1.1.3b.ebuild,v 1.1 2004/11/22 09:50:04 pclouds Exp $

DESCRIPTION="A small utility that converts among Vietnamese charsets"
SRC_URI="mirror://sourceforge/unikey/${PF}.tar.gz"
HOMEPAGE="http://unikey.sourceforge.net/linux.php"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE=""
DEPEND=""
S=${WORKDIR}/uvconv

src_compile() {
	make -C uvconvert || die
}

src_install () {
	exeinto /usr/bin
	doexe uvconvert/${PN}
	doman uvconv.1
	dodoc readme.txt AUTHORS CREDITS changes.txt gpl.txt
}
