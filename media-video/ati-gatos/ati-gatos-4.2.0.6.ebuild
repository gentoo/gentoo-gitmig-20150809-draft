# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/X11R6
DESCRIPTION="ATI drivers for Xfree86 that support ATI video capabilities"
SRC_URI="mirror://sourceforge/gatos/ATI-4.2.0-6.i386.tar.gz"
HOMEPAGE="http://gatos.sourceforge.net"

DEPEND="x11-base/xfree"

src_install () {
	dodoc ${S}/README* ${S}/ATI*
	cd ${S}/lib/modules
	insinto /usr/X11R6/lib/modules/multimedia
	doins multimedia/*
	insinto /usr/X11R6/lib/modules/drivers
	doins drivers/*
}
