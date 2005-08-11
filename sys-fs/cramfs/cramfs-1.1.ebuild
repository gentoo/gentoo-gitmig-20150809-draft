# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cramfs/cramfs-1.1.ebuild,v 1.6 2005/08/11 16:32:10 yoswink Exp $

DESCRIPTION="Linux filesystem designed to be simple, small, and to compress things well"
HOMEPAGE="http://sourceforge.net/projects/cramfs/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin mkcramfs cramfsck || die
	dodoc README NOTES
}
