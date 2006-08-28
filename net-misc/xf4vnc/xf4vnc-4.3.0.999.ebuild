# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xf4vnc/xf4vnc-4.3.0.999.ebuild,v 1.2 2006/08/28 17:27:48 mr_bones_ Exp $

DESCRIPTION="VNC (remote desktop viewer) derived from tightvnc but cooler :-)"
HOMEPAGE="http://xf4vnc.sourceforge.net/"
SRC_URI="x86? ( mirror://sourceforge/xf4vnc/${PN}-ix86-linux-${PV}.tar.gz )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE="xvnc vncviewer"
RESTRICT="strip"

RDEPEND="vncviewer? (
		!net-misc/tightvnc
		!net-misc/vnc
	)
	xvnc? (
		media-libs/freetype
		media-libs/jpeg
	)
	|| ( ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXaw
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXpm
		x11-libs/libXt )
	virtual/x11 )"

src_install() {
	exeinto /usr/lib/xorg/modules
	doexe vnc.so

	# Vnc extension library
	dolib.so libVncExt.so.2.0
	dosym libVncExt.so.2.0 /usr/lib/libVncExt.so.2
	dosym libVncExt.so.2.0 /usr/lib/libVncExt.so

	# Vnc extension headers
	insinto /usr/include/X11/extensions
	doins vnc*.h

	dobin vncevent

	use xvnc && dobin Xvnc
	if use vncviewer; then
		dobin vncviewer
		dolib.so *.so
	fi
}
