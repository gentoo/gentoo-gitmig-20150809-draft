# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.00-r1.ebuild,v 1.3 2001/10/12 00:51:06 hallski Exp $

S=${WORKDIR}/${P}
SRC_URI="http://flwm.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://flwm.sourceforge.net"
DESCRIPTION="A lightweight window manager based on fltk"

DEPEND=">=x11-base/xfree-4.0.1
	>=x11-libs/fltk-1.0.11
	opengl? ( virtual/opengl )
"

src_compile() {
    if [ "`use opengl`" ]; then
      export X_EXTRA_LIBS=-lGL
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install() {
    doman flwm.1
    dodoc README flwm_wmconfig
    into /usr
    dobin flwm
}
