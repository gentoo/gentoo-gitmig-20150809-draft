# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.8.ebuild,v 1.2 2006/04/10 03:42:06 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="SFV checksum utility (simple file verification)"
HOMEPAGE="http://zakalwe.virtuaalipalvelin.net/~shd/foss/cksfv/"
SRC_URI="http://zakalwe.virtuaalipalvelin.net/~shd/foss/cksfv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	# note: not an autoconf configure script
	./configure \
		--compiler=$(tc-getCC) \
		--prefix=/usr \
		--package-prefix="${D}" \
		--bindir=/usr/bin \
		--mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make install || die
	dodoc ChangeLog README TODO
}
