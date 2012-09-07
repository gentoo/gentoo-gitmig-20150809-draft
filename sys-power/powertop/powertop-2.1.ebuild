# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-2.1.ebuild,v 1.5 2012/09/07 11:48:13 pinkbyte Exp $

EAPI="4"

inherit eutils
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/fenrus75/powertop.git"
	inherit git-2
	SRC_URI=""
else
	SRC_URI="https://01.org/powertop/sites/default/files/downloads/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="https://01.org/powertop/ http://www.lesswatts.org/projects/powertop/"

LICENSE="GPL-2"
SLOT="0"
IUSE="unicode"

COMMON_DEPEND="
	dev-libs/libnl:3
	sys-apps/pciutils
	sys-devel/gettext
	sys-libs/ncurses[unicode?]
	sys-libs/zlib
"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	${COMMON_DEPEND}
	x11-apps/xset
"

DOCS=( TODO README )

src_configure() {
	export ac_cv_search_delwin=$(usex unicode -lncursesw -lncurses)
	default
}

src_compile() {
	#the clean is needed because the 2.1 tarball had object files in src/tuning/
	emake clean
	emake
}

src_install() {
	default
	keepdir /var/cache/powertop
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the"
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)"
	echo
}
