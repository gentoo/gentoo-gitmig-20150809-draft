# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.6.ebuild,v 1.2 2005/08/16 23:15:52 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="SFV checksum utility (simple file verification)"
HOMEPAGE="http://zakalwe.virtuaalipalvelin.net/~shd/foss/cksfv/"
SRC_URI="http://zakalwe.virtuaalipalvelin.net/~shd/foss/cksfv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
src_compile() {
	# note: not an autoconf configure script
	./configure \
		--compiler=$(tc-getCC) \
		--prefix=/usr \
		--bindir=/usr/bin \
		--mandir=/usr/share/man || die
	emake || die
}

src_install() {
	dobin src/cksfv || die
	doman cksfv.1
	dodoc ChangeLog INSTALL README TODO
}
