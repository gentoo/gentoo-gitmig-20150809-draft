# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpglen/mpglen-0.1.ebuild,v 1.3 2005/07/28 10:43:24 dholm Exp $

IUSE=""

MY_S=${WORKDIR}/${PN}

DESCRIPTION="A program to scan through a MPEG file and count the number of GOPs and frames"
HOMEPAGE="http://www.iamnota.net/mpglen/"
SRC_URI="http://www.iamnota.net/mpglen/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc"

src_compile () {
	cd ${MY_S} || die
	emake || die
}

src_install () {
	cd ${MY_S} || die
	dobin ${PN} || die
	dodoc AUTHORS COPYING Changelog README || die
}
