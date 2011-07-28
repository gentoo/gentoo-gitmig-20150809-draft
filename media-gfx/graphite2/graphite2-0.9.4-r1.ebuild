# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphite2/graphite2-0.9.4-r1.ebuild,v 1.3 2011/07/28 19:26:22 scarabeus Exp $

EAPI=4

inherit base cmake-utils perl-module

DESCRIPTION="Library providing rendering capabilities for complex non-Roman writing systems"
HOMEPAGE="http://graphite.sil.org/"
SRC_URI="mirror://sourceforge/silgraphite/${PN}/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="perl"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
	perl? ( dev-lang/perl )
"
DEPEND="${RDEPEND}
	perl? ( virtual/perl-Module-Build )
"

PATCHES=(
	"${FILESDIR}/${PN}-includes-libs-perl.patch"
	"${FILESDIR}/${PN}-disablefonttest.patch"
	"${FILESDIR}/${PN}-multilib-strict.patch"
)

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_prepare() {
	base_src_prepare

	# fix CFLAGS
	sed -i \
		-e 's:-nodefaultlibs -nostdlibs::' \
		src/CMakeLists.txt || die

	# fix perl linking
	if use perl; then
		_check_build_dir init
		sed -i \
			-e "s:@BUILD_DIR@:\"${CMAKE_BUILD_DIR}/src\":" \
			perl/Build.PL || die
	fi
}

src_configure() {
	local mycmakeargs=(
		"-DVM_MACHINE_TYPE=direct"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use perl; then
		cd perl
		perl-module_src_prep
		perl-module_src_compile
	fi
}

src_test() {
	cmake-utils_src_test
	if use perl; then
		cd perl
		perl-module_src_test
	fi
}

src_install() {
	cmake-utils_src_install
	if use perl; then
		cd perl
		perl-module_src_install
		fixlocalpod
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +

}
