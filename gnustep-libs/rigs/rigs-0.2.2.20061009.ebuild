# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/rigs/rigs-0.2.2.20061009.ebuild,v 1.5 2008/03/23 18:40:44 nixnut Exp $

inherit gnustep-2

DESCRIPTION="Ruby Interface for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/RIGS.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
RESTRICT="test"

DEPEND="dev-lang/ruby"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-install-rb.patch
}

src_install() {
	gnustep-base_src_install

	# install examples
	if use doc; then
		cd "${S}"
		dodir ${GNUSTEP_SYSTEM_DOC}/RIGS
		cp -pPR Examples "${D}"/${GNUSTEP_SYSTEM_DOC}/RIGS
	fi
}
