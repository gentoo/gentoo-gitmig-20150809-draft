# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.19.3-r1.ebuild,v 1.5 2005/01/08 19:47:19 pylon Exp $

inherit eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="http://www.gnu.org/software/unrtf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc ~s390"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-final.patch
	# in 0.19.3 it's a tar file of 0.19.2
	rm ${S}/AUTHORS
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin unrtf
	doman unrtf.1
	dohtml doc/unrtf.html
	dodoc CHANGES README TODO
}
