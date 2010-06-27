# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtm/qtm-1.1.1.ebuild,v 1.2 2010/06/27 19:01:00 angelos Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Qt4 blogging client"
HOMEPAGE="http://qtm.blogistan.co.uk"
SRC_URI="mirror://sourceforge/catkin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"
RESTRICT="strip"

RDEPEND="x11-libs/qt-gui:4[debug?]
	x11-proto/xproto
	dev-lang/perl
	virtual/perl-Digest-MD5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

CMAKE_IN_SOURCE_BUILD="1"

DOCS="Changelog README"

src_configure() {
	mycmakeargs="-DUSE_STI=TRUE -DDONT_USE_PTE=FALSE -DINSTALL_MARKDOWN=TRUE $(cmake-utils_use debug QDEBUG)"
	cmake-utils_src_configure
}
