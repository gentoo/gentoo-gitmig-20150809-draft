# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.61.1-r1.ebuild,v 1.1 2001/10/12 01:02:45 hallski Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="A Small fast full featured window manager for X"
SRC_URI="ftp://portal.alug.org/pub/blackbox/0.6x.x/${P}.tar.gz"
HOMEPAGE="http://blackbox.alug.org/"

DEPEND=">=x11-base/xfree-4.0"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr/X11R6					\
		    --sysconfdir=/etc/X11/blackbox

	emake || die
}

src_install () {
	emake prefix=${D}/usr						\
	      sysconfdir=${D}/etc/X11/blackbox				\
	      install || die

	dodoc ChangeLog* AUTHORS LICENSE README* TODO*
}
