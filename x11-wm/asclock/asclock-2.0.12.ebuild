# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/asclock/asclock-2.0.12.ebuild,v 1.2 2001/12/14 01:38:52 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Clock applet for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asclock/asclock-2.0.12.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
DEPEND="virtual/glibc virtual/x11"

src_unpack() {
    unpack asclock-2.0.12.tar.gz
	cd ${S}
	ln -s themes/classic default_theme
}

src_compile() {
    local x
	cd ${S}
	for x in asclock parser symbols config
	do
		gcc ${CFLAGS} -I/usr/X11R6/include  -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -DFUNCPROTO=15 -DNARROWPROTO -c -o ${x}.o ${x}.c || die
	done
	gcc ${CFLAGS} -o asclock -L/usr/X11R6/lib asclock.o parser.o symbols.o config.o -L/usr/lib/X11 -lXpm -lXext -lX11 || die  
}

src_install () {
    dobin asclock
    insinto usr/share/asclock
    for i in themes/* ; do
      cp -r $i ${D}/usr/share/asclock/;
    done
	dodoc COPYING INSTALL README README.THEMES TODO
	cd ${S}
}

