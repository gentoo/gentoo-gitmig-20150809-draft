# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/compton/compton-9999.ebuild,v 1.2 2012/09/26 18:21:50 hasufell Exp $

EAPI=4

inherit toolchain-funcs git-2

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="http://github.com/chjj/compton"
SRC_URI=""

EGIT_REPO_URI="git://github.com/chjj/compton.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-libs/libconfig
	dev-libs/libpcre
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender"
RDEPEND="${COMMON_DEPEND}
	app-shells/bash
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

pkg_setup() {
	tc-export CC
}
