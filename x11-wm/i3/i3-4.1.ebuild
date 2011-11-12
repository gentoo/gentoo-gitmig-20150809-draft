# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/i3/i3-4.1.ebuild,v 1.1 2011/11/12 09:43:11 xarthisius Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An improved dynamic tiling window manager"
HOMEPAGE="http://i3wm.org/"
SRC_URI="http://i3wm.org/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/libev
	dev-libs/libpcre
	dev-libs/yajl
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/startup-notification
	x11-libs/xcb-util"
DEPEND="${CDEPEND}
	app-text/asciidoc
	dev-util/pkgconfig
	sys-devel/flex
	sys-devel/bison
	x11-proto/xcb-proto"
RDEPEND="${CDEPEND}
	dev-perl/AnyEvent-I3
	dev-perl/IPC-Run
	dev-perl/Try-Tiny
	virtual/perl-Getopt-Long
	x11-apps/xmessage"

DOCS=( RELEASE-NOTES-${PV} )

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i common.mk \
		-e "/DEBUG=/ s/1/0/" \
		-e '/O2\|reorder\-blocks\|SILENT/d' || die
}

src_install() {
	default
	dohtml -r docs/*
	doman i3bar/doc/i3bar.1 man/*.1
}
