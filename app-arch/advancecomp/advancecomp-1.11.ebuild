# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/advancecomp/advancecomp-1.11.ebuild,v 1.3 2004/09/12 19:09:36 taviso Exp $

inherit eutils

DESCRIPTION="Recompress ZIP, PNG and MNG using deflate 7-Zip, considerably improving compression"
HOMEPAGE="http://advancemame.sourceforge.net/comp-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="png mng"

DEPEND="sys-libs/zlib app-arch/bzip2"

src_unpack() {
	unpack ${A}

	# bzip2 support wont compile, heres a quick patch.
	cd ${S}; epatch ${FILESDIR}/${P}-bzip2-compile-plz-k-thx.diff

	epatch ${FILESDIR}/${P}-64bit.diff
}

src_compile() {
	econf --enable-bzip2 || die
	emake || die
}

src_install() {
	dobin advdef advzip

	use png && {
		dobin advpng
		doman doc/advpng.1
	}

	use mng && {
		dobin advmng
		doman doc/advmng.1
	}

	dodoc HISTORY AUTHORS INSTALL README
	doman doc/advdef.1 doc/advzip.1
}
