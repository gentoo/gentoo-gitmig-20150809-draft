# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.8.5.ebuild,v 1.5 2004/11/07 17:02:19 sekretarz Exp $

inherit flag-o-matic

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-devel/gcc-3.2
	dev-util/pkgconfig
	>=app-sci/openbabel-1.100.2*"

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
