# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpglen/mpglen-0.1.ebuild,v 1.1 2004/10/06 20:08:02 trapni Exp $

DESCRIPTION="A program to scan through a MPEG file and count the number of GOPs and frames"
SRC_URI="http://www.iamnota.net/mpglen/${PN}.tar.gz"
HOMEPAGE="http://www.iamnota.net/mpglen/"
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
SLOT="0"
IUSE=""

MY_S=${WORKDIR}/${PN}

src_compile () {
	cd ${MY_S} || die
	emake || die
}

src_install () {
	cd ${MY_S} || die
	dobin ${PN} || die
	dodoc AUTHORS COPYING Changelog README || die
}
