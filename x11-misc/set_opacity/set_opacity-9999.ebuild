# Copyright 1999-2011 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/set_opacity/set_opacity-9999.ebuild,v 1.1 2011/07/21 11:12:03 maksbotan Exp $

EAPI="4"

EGIT_REPO_URI="git://gitorious.org/x11-tools/set_opacity.git"

inherit git-2 toolchain-funcs

DESCRIPTION="Tool for set real compositing for windows through window's id, process' pid etc."
HOMEPAGE="https://gitorious.org/x11-tools/set_opacity"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXrender"
RDEPEND=${DEPEND}

KEYWORDS=""

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin set_opacity
}
