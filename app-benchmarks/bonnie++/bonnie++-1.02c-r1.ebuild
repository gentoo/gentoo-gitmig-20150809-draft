# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bonnie++/bonnie++-1.02c-r1.ebuild,v 1.2 2003/08/01 20:09:19 vapier Exp $

DESCRIPTION="Hard drive bottleneck testing benchmark suite"
HOMEPAGE="http://www.coker.com.au/bonnie++/"
SRC_URI="http://www.coker.com.au/bonnie++/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="debug"

src_compile() {
	local myconf="`use_with debug`"
	[ `use debug` ] \
		&& myconf="${myconf} --disable-stripping" \
		|| myconf="${myconf} --enable-stripping"

	econf ${myconf} || die
	emake || die "emake failed"
	emake zcav || die "emake zcav failed" # see #9073
}

src_install() {
	dosbin bonnie++ zcav
	dobin bon_csv2html bon_csv2txt
	doman bon_csv2html.1 bon_csv2txt.1 bonnie++.8 zcav.8
	dohtml readme.html
	dodoc changelog.txt copyright.txt credits.txt
}
