# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-9999.ebuild,v 1.6 2011/05/03 11:34:23 scarabeus Exp $

EAPI=4

inherit eutils toolchain-funcs git-2

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="http://www.lesswatts.org/projects/powertop/"
SRC_URI=""
EGIT_REPO_URI="git://git.kernel.org/pub/scm/status/powertop/powertop.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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
	net-wireless/bluez
	x11-apps/xset
"

DOCS=( TODO README )

src_prepare() {
	use unicode || sed -i 's:-lncursesw:-lncurses:' Makefile
	# fix ldflags
	sed -i \
		-e '/-o powertop/s:g++:$(CXX) $(CFLAGS) $(LDFLAGS):' \
		-e 's: -O2 -g -fno-omit-frame-pointer -fstack-protector::g' \
		-e 's:gcc:$(CC) $(CFLAGS):' \
		Makefile || die
}

src_configure() {
	tc-export CC CXX
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
