# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-9999.ebuild,v 1.12 2012/06/01 17:42:02 vapier Exp $

EAPI="4"

inherit eutils
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/fenrus75/powertop.git"
	inherit git-2
	SRC_URI=""
else
	SRC_URI="https://01.org/powertop/sites/default/files/downloads/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="https://01.org/powertop/ http://www.lesswatts.org/projects/powertop/"

LICENSE="GPL-2"
SLOT="0"
IUSE="unicode"

DEPEND="
	dev-libs/libnl
	sys-apps/pciutils
	sys-devel/gettext
	sys-libs/ncurses[unicode?]
	sys-libs/zlib
"
RDEPEND="
	${DEPEND}
	x11-apps/xset
"

DOCS=( TODO README )

src_configure() {
	export ac_cv_search_delwin=$(usex unicode -lncursesw no)
	default
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
