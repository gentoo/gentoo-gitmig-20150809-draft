# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/burrow-owl/burrow-owl-1.2.ebuild,v 1.1 2007/06/06 23:32:33 dberkholz Exp $

inherit eutils autotools

SRC_PN="${PN/-owl}"
SRC_P="${SRC_PN}-${PV}"
DESCRIPTION="Visualize multidimensional nuclear magnetic resonance (NMR) spectra"
HOMEPAGE="http://burrow-owl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${SRC_P}.tar.gz
	examples? ( mirror://sourceforge/${PN}/${SRC_PN}-demos.tar )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"
RDEPEND="=x11-libs/gtk+-2*
	dev-scheme/guile-gnome-platform"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
S="${WORKDIR}/${SRC_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-make-script-dir.patch
	rm -rf guile-gnome
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use examples; then
		pushd "${WORKDIR}"/burrow-demos
		docinto demonstration
		dodoc * || die "dodoc demo failed"
		cd data
		docinto demonstration/data
		dodoc * || die "dodoc data failed"
		popd
	fi
}
