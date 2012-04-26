# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/wcalc/wcalc-2.2.1.ebuild,v 1.6 2012/04/26 15:51:28 jlec Exp $

EAPI=4

DESCRIPTION="A flexible command-line scientific calculator"
HOMEPAGE="http://w-calc.sourceforge.net/"
SRC_URI="mirror://sourceforge/w-calc/Wcalc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="readline"

DEPEND="
	dev-libs/gmp
	dev-libs/mpfr
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/Wcalc-${PV}

src_configure() {
	econf $(use_with readline)
}

src_install() {
	default

	# Wcalc icons
	newicon w.png wcalc.png
	newicon Wred.png wcalc-red.png
}
