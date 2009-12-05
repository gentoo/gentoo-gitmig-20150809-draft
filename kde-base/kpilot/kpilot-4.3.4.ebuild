# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpilot/kpilot-4.3.4.ebuild,v 1.2 2009/12/05 05:11:30 abcd Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KPilot is software for syncing PalmOS based handhelds."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avantgo crypt debug +handbook"

DEPEND="
	>=app-pda/pilot-link-0.12
	$(add_kdebase_dep libkdepim)
	avantgo? ( >=dev-libs/libmal-0.40 )
	crypt? ( app-crypt/qca:2 )
"
RDEPEND="${DEPEND}"

# Tests hang, last checked in 4.3.3
RESTRICT="test"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with avantgo Mal)
		$(cmake-utils_use_with crypt QCA2)"

	kde4-meta_src_configure
}

src_test() {
	# disable broken test (as of 4.2.87)
	sed -i -e '/keyringcategorysynctest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/"${PN}"/conduits/keyringconduit/tests/CMakeLists.txt || \
		die "sed to disable keyringcategorysynctest failed."

	kde4-meta_src_test
}
