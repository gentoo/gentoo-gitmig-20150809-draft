# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/asclock/asclock-2.0.12.ebuild,v 1.1 2001/09/27 21:59:33 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Clock applet for AfterStep"

SRC_URI="http://www.tigr.net/afterstep/download/asclock/asclock-2.0.12.tar.gz"

HOMEPAGE="http://www.tigr.net/afterstep/list.pl"

DEPEND="virtual/glibc virtual/x11"

src_unpack() {
    unpack asclock-2.0.12.tar.gz
    cd ${S}
    cp configure configure.orig
    cp classic.configure classic.configure.orig
    sed "s/read line/line=classic/" < configure.orig > configure
    sed "s/read LANG/LANG=english/" < classic.configure.orig > classic.configure
}

src_compile() {
    ./configure
    emake || die
}

src_install () {
    dobin asclock
    insinto usr/share/asclock
    for i in themes/* ; do
      cp -r $i ${D}/usr/share/asclock/;
    done
    dodoc COPYING INSTALL README README.THEMES TODO
}

