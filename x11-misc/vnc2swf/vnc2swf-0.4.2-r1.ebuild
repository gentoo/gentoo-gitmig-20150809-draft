# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vnc2swf/vnc2swf-0.4.2-r1.ebuild,v 1.3 2005/06/20 00:15:41 smithj Exp $

inherit eutils

DESCRIPTION="A tool for recording Flash SWF movies from VNC sessions"
HOMEPAGE="http://www.unixuser.org/~euske/vnc2swf"
SRC_URI="http://www.unixuser.org/~euske/vnc2swf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="x11vnc"

DEPEND=">=media-libs/ming-0.2a
	virtual/libc
	virtual/x11
	sys-apps/sed
	x11vnc? ( x11-misc/x11vnc )
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}
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
