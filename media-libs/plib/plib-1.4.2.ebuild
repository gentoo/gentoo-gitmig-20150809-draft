# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.4.2.ebuild,v 1.1 2002/01/16 10:26:06 gbevin Exp $

S=${WORKDIR}/${P}
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

HOMEPAGE="http://plib.sourceforge.net"
DESCRIPTION="plib: a multimedia library used by many games"

DEPEND="virtual/x11
		virtual/glut"

src_install () {

    einstall || die

}
