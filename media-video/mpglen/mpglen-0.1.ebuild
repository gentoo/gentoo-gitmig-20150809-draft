# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpglen/mpglen-0.1.ebuild,v 1.5 2006/03/07 16:45:06 flameeyes Exp $

inherit toolchain-funcs flag-o-matic

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="A program to scan through a MPEG file and count the number of GOPs and frames"
HOMEPAGE="http://www.iamnota.net/mpglen/"
SRC_URI="http://www.iamnota.net/mpglen/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_unpack() {
	unpack ${A}

	sed -i -e 's:gcc .* -o:$(CC) $(CFLAGS) $(LDFLAGS) -o:' ${S}/Makefile
}

src_compile () {
	append-lfs-flags
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dobin ${PN} || die
	dodoc AUTHORS Changelog README || die
}
