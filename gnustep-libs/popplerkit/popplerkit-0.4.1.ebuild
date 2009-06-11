# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/popplerkit/popplerkit-0.4.1.ebuild,v 1.4 2009/06/11 21:45:13 maekke Exp $

EAPI=2

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Frameworks/PopplerKit"

DESCRIPTION="PopplerKit is a GNUstep/Cocoa framework for accessing and rendering PDF content."
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/poppler-0.6
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.0-config-as-needed.patch

	cd "${WORKDIR}/Etoile-${PV}"
	sed -i -e "s/-Werror//" etoile.make || die "sed failed"
}

src_compile() {
	# Compile MissingKit separately
	cd "${S}"/MissingKit
	gnustep-base_src_compile
	cd "${S}"
	gnustep-base_src_compile
}
