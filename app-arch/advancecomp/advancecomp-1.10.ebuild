# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/advancecomp/advancecomp-1.10.ebuild,v 1.7 2004/09/03 22:43:03 kloeri Exp $

inherit eutils

DESCRIPTION="Recompress ZIP, PNG and MNG using deflate 7-Zip, considerably improving compression"
HOMEPAGE="http://advancemame.sourceforge.net/comp-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha ~amd64"
IUSE="png"

DEPEND="sys-libs/zlib
	app-arch/bzip2"

src_unpack() {
	unpack ${A}
	# bzip2 support wont compile, heres a quick patch.
	epatch ${FILESDIR}/${P}-64bit.diff
	cd ${S}; epatch ${FILESDIR}/${P}-bzip2-compile-plz-k-thx.diff
}

src_compile() {
	econf --enable-bzip2 || die
	emake || die
}

src_install() {
	dobin advdef advzip
	use png && dobin advpng advmng

	dodoc HISTORY AUTHORS INSTALL README

	doman doc/advdef.1 doc/advzip.1
	use png && doman doc/advmng.1 doc/advpng.1
}
