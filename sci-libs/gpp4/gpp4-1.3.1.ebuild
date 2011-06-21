# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gpp4/gpp4-1.3.1.ebuild,v 1.3 2011/06/21 15:18:38 jlec Exp $

EAPI="4"

inherit fortran-2

DESCRIPTION="A standalone, drop-in replacement for the CCP4 library"
HOMEPAGE="https://launchpad.net/gpp4/"
SRC_URI="http://launchpad.net/${PN}/1.3/${PV}/+download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="fortran static-libs"

RDEPEND="
	fortran? ( virtual/fortran )
	sci-libs/mmdb"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_with fortran fortran-api) \
		$(use_enable static-libs static)
}
