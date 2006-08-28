# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xf4vnc/xf4vnc-4.3.0.103.ebuild,v 1.5 2006/08/28 17:24:24 mr_bones_ Exp $

DESCRIPTION="VNC (remote desktop viewer) derived from tightvnc but cooler :-)"
HOMEPAGE="http://xf4vnc.sourceforge.net/"
SRC_URI="alpha? ( mirror://sourceforge/xf4vnc/${PN}-alpha-linux-${PV}.tar.gz )"

case ${ARCH} in
	alpha)
		S=${WORKDIR}/${PN}-alpha-linux-${PV}
	;;
esac

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha -*"
IUSE=""

DEPEND="
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
	insinto /usr/X11R6/lib/modules/
	doins vnc.so
	insinto /usr/X11R6/lib/
	doins libVncExt.so.2.0
	dosym /usr/X11R6/lib/libVncExt.so.2.0 /usr/X11R6/lib/libVncExt.so.2
	dosym /usr/X11R6/lib/libVncExt.so.2.0 /usr/X11R6/lib/libVncExt.so
	doins *.so
	insinto /usr/X11R6/include/X11/extensions
	doins vnc*.h
	exeinto /usr/X11R6/bin
	doexe vncevent
	doexe Xvnc
	doexe vncviewer
}
