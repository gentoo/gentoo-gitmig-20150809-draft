# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/advancecomp/advancecomp-1.8.ebuild,v 1.4 2004/04/06 03:27:59 vapier Exp $

inherit eutils

DESCRIPTION="Recompress ZIP, PNG and MNGs using the Deflate 7-Zip implementation"
HOMEPAGE="http://advancemame.sourceforge.net/comp-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

DEPEND="sys-libs/zlib app-arch/bzip2"

src_unpack() {
	unpack ${A}

	# bzip2 support wont compile, heres a quick patch.
	cd ${S}; epatch ${FILESDIR}/${PN}-bzip2-compile-plz-k-thx.diff
}

src_compile() {
	econf --enable-bzip2 || die
	emake || die
}

src_install() {
	dobin advdef advmng advpng advzip || die
	dodoc HISTORY AUTHORS INSTALL README
	doman doc/advdef.1 doc/advmng.1 doc/advpng.1 doc/advzip.1
}
