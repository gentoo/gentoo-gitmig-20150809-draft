# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/app-misc/toolbox/toolbox-0.6.0.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="blackbox style file configuration utility"
SRC_URI="http://movingparts.windsofstorm.net/bbkeys/${A}"
HOMEPAGE="http://movingparts.windsofstorm.net/code.shtml#toolbox"

DEPEND=">=x11-wm/blackbox-0.61 
	>=x11-libs/qt-x11-2.3.0"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

