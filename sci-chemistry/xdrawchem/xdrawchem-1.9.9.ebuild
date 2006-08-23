# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xdrawchem/xdrawchem-1.9.9.ebuild,v 1.4 2006/08/23 09:30:14 blubb Exp $

inherit qt3

DESCRIPTION="Molecular structure drawing program"
HOMEPAGE="http://xdrawchem.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="$(qt_min_version 3.1)
	>=sys-devel/gcc-3.2
	dev-util/pkgconfig
	>=sci-chemistry/openbabel-2"

src_compile() {
	# make sure we use moc from Qt, not from eg media-sound/moc
	PATH="${QTDIR}/bin:${PATH}"
	econf || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."
	cd ${D}/usr/share
	dodir /usr/share/doc
	mv xdrawchem/doc doc/${PF}
	dosym /usr/share/doc/${PF} /usr/share/xdrawchem/doc
}
