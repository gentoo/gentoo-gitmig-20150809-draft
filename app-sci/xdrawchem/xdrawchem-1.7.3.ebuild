# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.7.3.ebuild,v 1.2 2003/08/05 18:41:03 vapier Exp $

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="qt"

DEPEND="qt? ( >=x11-libs/qt-3.1.0 )"

src_compile() {
	./configure --prefix=/usr || die
	# make sure we use moc from Qt, not from eg media-sound/moc
	sed -i /^MOC/s/moc/$(echo ${QTDIR}|sed 's/\//\\\//g')\\/bin\\/moc/ xdrawchem/Makefile
	emake -f Makefile INSTRING=/usr/share/xdrawchem || die
}

src_install() {
	dodir /usr/bin
	dobin xdrawchem/xdrawchem

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
	dohtml doc/*
}
