# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.7.4.ebuild,v 1.1 2011/12/11 18:52:30 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug fits indi"

DEPEND="
	dev-cpp/eigen:2
	$(add_kdebase_dep libkdeedu)
	fits? ( >=sci-libs/cfitsio-0.390 )
	indi? ( >=sci-libs/indilib-0.6.2[fits?] )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-4.4.65-solaris.patch
)

src_configure() {
	# Bug 308903
	use ppc64 && append-flags -mminimal-toc

	mycmakeargs=(
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with indi)
	)

	kde4-base_src_configure
}
