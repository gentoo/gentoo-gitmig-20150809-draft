# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bonnie++/bonnie++-1.93c.ebuild,v 1.1 2004/07/22 17:24:09 morfic Exp $

DESCRIPTION="Hard drive bottleneck testing benchmark suite."
HOMEPAGE="http://www.coker.com.au/bonnie++/"
SRC_URI="http://www.coker.com.au/bonnie++/experimental/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~amd64"
IUSE="debug"

DEPEND="virtual/libc"

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
