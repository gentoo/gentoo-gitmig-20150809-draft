# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bonnie++/bonnie++-1.93c.ebuild,v 1.6 2005/03/29 05:24:01 agriffis Exp $

inherit eutils 64-bit

DESCRIPTION="Hard drive bottleneck testing benchmark suite."
HOMEPAGE="http://www.coker.com.au/bonnie++/"
SRC_URI="http://www.coker.com.au/bonnie++/experimental/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"
IUSE="debug"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	64-bit && epatch ${FILESDIR}/${P}-64bit.patch
}

src_compile() {
	econf \
		`use_with debug` \
		`use_enable !debug stripping` \
		|| die
	emake || die "emake failed"
	emake zcav || die "emake zcav failed" # see #9073
}

src_install() {
	dosbin bonnie++ zcav || die
	dobin bon_csv2html bon_csv2txt || die
	doman bon_csv2html.1 bon_csv2txt.1 bonnie++.8 zcav.8
	dohtml readme.html
	dodoc changelog.txt credits.txt
}
