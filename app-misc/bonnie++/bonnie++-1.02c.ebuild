# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bonnie++/bonnie++-1.02c.ebuild,v 1.6 2003/02/13 08:53:26 vapier Exp $

DESCRIPTION="Hard drive bottleneck testing benchmark suite."
SRC_URI="http://www.coker.com.au/bonnie++/${P}.tgz"
HOMEPAGE="http://www.coker.com.au/bonnie++/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	[ "$DEBUG" == "true" ] && myconf="--with-debug --disable-stripping"
	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	# make install doesn't respect DESTDIR or anything else.
	#make DESTDIR=${D} install || die "make install failed"
	# make install-bin will respect eprefix but would still need clean up
	#make eprefix=${D} install-bin || die "make install-bin failed"

	# Explicit
	dobin bonnie++ zcav
	dobin bon_csv2html bon_csv2txt
	doman bon_csv2html.1 bon_csv2txt.1 bonnie++.8 zcav.8
	dohtml readme.html
	dodoc changelog.txt copyright.txt credits.txt
}
