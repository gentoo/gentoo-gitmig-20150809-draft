# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.8.6.ebuild,v 1.7 2012/04/25 16:25:58 jlec Exp $

inherit autotools gnustep-2

S=${WORKDIR}/${P/gw/GW}

DESCRIPTION="A workspace manager for GNUstep"
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="http://www.gnustep.it/enrico/gworkspace/${P}.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="pdf"
DEPEND="pdf? ( gnustep-libs/popplerkit )
	>=gnustep-apps/systempreferences-1.0.1_p24791
	>=dev-db/sqlite-3.2.8"
RDEPEND="!gnustep-apps/desktop
	!gnustep-apps/recycler"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-rpath.patch
	epatch "${FILESDIR}"/${P}-popplerkit.patch

	cd Inspector
	eautoreconf
}

src_compile() {
	local myconf=""

	use kernel_linux && myconf="${myconf} --with-inotify"

	egnustep_env
	econf ${myconf}
	egnustep_make

	cd "${S}"/GWMetadata
	econf
	egnustep_make || die "GWMetadata make failed"
}

src_install() {
	egnustep_env

	egnustep_install

	cd "${S}"/GWMetadata
	egnustep_install

	if use doc;
	then
		dodir /usr/share/doc/${PF}
		cp "${S}"/Documentation/*.pdf "${D}"/usr/share/doc/${PF}
	fi
}
