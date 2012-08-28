# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/simpleswitcher/simpleswitcher-9999.ebuild,v 1.1 2012/08/28 11:29:44 xmw Exp $

EAPI=4

inherit git-2 toolchain-funcs

DESCRIPTION="lightweight EWMH window switcher with features and looks of dmenu"
HOMEPAGE="https://github.com/seanpringle/simpleswitcher"
EGIT_REPO_URI="https://github.com/seanpringle/simpleswitcher"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	tc-export CC
	default
}

src_install() {
	default
	doman ${PN}.1
	dodoc README.md
}
