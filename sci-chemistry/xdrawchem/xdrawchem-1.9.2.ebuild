# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xdrawchem/xdrawchem-1.9.2.ebuild,v 1.1 2005/02/22 06:26:03 phosphan Exp $

inherit flag-o-matic

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-devel/gcc-3.2
	dev-util/pkgconfig
	>=sci-chemistry/openbabel-1.100.2*"

src_compile() {
	append-flags -O0 # incredible compile times otherwise
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
