# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neotools/neotools-0.8.2.ebuild,v 1.4 2009/01/23 10:58:08 tupone Exp $

inherit eutils autotools

DESCRIPTION="Various development tools for NeoEngine"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/neotools-${PV}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-games/neoengine-${PV}"

S="${WORKDIR}/neotools"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e 's/BUILD_STATIC/BUILD_DYNAMIC/g' \
		-e 's/_static//g' \
		nscemake/Makefile.am || die "makefile sed failed"
	sed -i \
		-e 's/ -Werror//' \
		configure.in

	epatch "${FILESDIR}"/${P}-errno.patch \
		"${FILESDIR}"/${P}-gcc43.patch

	eautoreconf || die "eautoreconf failed"
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog*
}
