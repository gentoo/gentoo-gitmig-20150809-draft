# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvibook/dvibook-20001129.ebuild,v 1.1 2004/09/02 05:22:19 usata Exp $

inherit eutils

DESCRIPTION="DVI file utilities: dvibook, dviconcat, dvitodvi, and dviselect."
HOMEPAGE="http://www.ctan.org/tex-archive/dviware/dvibook/"
# Taken from: ftp://tug.ctan.org/tex-archive/dviware/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="dvibook"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/x11"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	xmkmf -a || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install install.man || die

	dodoc README
}
