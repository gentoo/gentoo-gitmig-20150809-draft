# Copyright 1999-2003 Gentoo Technologies, Inc.<br>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmctrl/wmctrl-1.04.ebuild,v 1.1 2003/11/05 15:49:55 tseng Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The wmctrl program is a command line tool to interact with an EWMH/NetWM compatible X Window Manager."
SRC_URI="http://sweb.cz/tripie/utils/wmctrl/dist/${P}.tar.gz"
HOMEPAGE="http://sweb.cz/tripie/utils/wmctrl/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""
SLOT="0"

DEPEND="virtual/x11"

src_install () {

dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
make DESTDIR=${D} install || die
}
