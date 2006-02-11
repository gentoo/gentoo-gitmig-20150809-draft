# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vnc2swf/vnc2swf-0.5.0.ebuild,v 1.1 2006/02/11 12:16:32 nelchael Exp $

inherit eutils

DESCRIPTION="A tool for recording Flash SWF movies from VNC sessions"
HOMEPAGE="http://www.unixuser.org/~euske/vnc2swf"
SRC_URI="http://www.unixuser.org/~euske/vnc2swf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="x11vnc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXaw
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto )
	virtual/x11 )
	>=media-libs/ming-0.2a
	sys-apps/sed
	x11vnc? ( x11-misc/x11vnc )
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -ie "s:docs:html:" README
	sed -ie "s:-mouse ::" recordwin.sh
}

src_install() {
	dobin vnc2swf
	if use x11vnc; then
		# this USE flag is needed because recordwin
		# only works on x11vnc
		newbin recordwin.sh recordwin
		dosed "s:./vnc2swf:vnc2swf:" /usr/bin/recordwin
	fi
	insinto /etc/X11/app-defaults
	newins Vnc2Swf.ad Vnc2Swf
	dodoc README TODO sample.html
	dohtml docs/*
	dohtml -a swf docs/*
}
