# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.7.8.ebuild,v 1.4 2004/10/25 09:31:20 phosphan Exp $

inherit flag-o-matic

# There seems to be an issue with gcc 3.3.1, for the moment use -O0 only
filter-flags -O1 -O2 -O3 -Os
CXXFLAGS="-O0 ${CXXFLAGS}"

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=x11-libs/qt-3.1.0
	dev-util/pkgconfig
	>=app-sci/openbabel-1.100.2*"

src_compile() {
	# make sure we use moc from Qt, not from eg media-sound/moc
	PATH="${QTDIR}/bin:${PATH}"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	cd ${D}/usr/share
	dodir /usr/share/doc
	mv xdrawchem/doc doc/xdrawchem
	dosym /usr/share/doc/xdrawchem /usr/share/xdrawchem/doc
}
