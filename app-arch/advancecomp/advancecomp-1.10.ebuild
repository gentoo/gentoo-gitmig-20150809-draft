# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/advancecomp/advancecomp-1.10.ebuild,v 1.2 2004/05/30 00:50:56 kugelfang Exp $

inherit eutils

IUSE="png"

DESCRIPTION="Recompress ZIP, PNG and MNG using deflate 7-Zip, considerably improving compression"
HOMEPAGE="http://advancemame.sourceforge.net/comp-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64"
DEPEND="sys-libs/zlib app-arch/bzip2"

src_unpack() {
	unpack ${A}
	# bzip2 support wont compile, heres a quick patch.
	cd ${S}; epatch ${FILESDIR}/${P}-bzip2-compile-plz-k-thx.diff
}

src_compile() {
	econf --enable-bzip2 || die
	emake || die
}

src_install() {
	dobin advdef advzip
	use png && dobin advpng advmng

	dodoc HISTORY AUTHORS COPYING INSTALL README

	doman doc/advdef.1 doc/advzip.1
	use png && doman doc/advmng.1 doc/advpng.1
}
