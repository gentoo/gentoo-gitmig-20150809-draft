# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lasi/lasi-1.1.0.ebuild,v 1.2 2008/10/25 22:35:28 pvdabeel Exp $

inherit eutils cmake-utils multilib

MY_PN="libLASi"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="C++ library for postscript stream output"
HOMEPAGE="http://www.unifont.org/lasi/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS NEWS NOTES README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:\/lib$:\/$(get_libdir):" \
		-i cmake/modules/instdirs.cmake \
		|| die "Failed to fix cmake files for multilib."
}
