# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cramfs/cramfs-1.1.ebuild,v 1.2 2004/06/24 22:49:58 agriffis Exp $

DESCRIPTION="Linux filesystem designed to be simple, small, and to compress things well"
HOMEPAGE="http://sf.net/projects/cramfs/"
LICENSE="GPL-2"
DEPEND="sys-libs/zlib
	virtual/glibc"
KEYWORDS="~x86 amd64 ~ppc ~sparc"

SLOT="0"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install () {
	into /
	dosbin mkcramfs cramfsck
	dodoc README NOTES
}
