# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/toolbox/toolbox-0.6.0-r1.ebuild,v 1.8 2002/08/01 11:59:04 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox style file configuration utility"
SRC_URI="http://movingparts.windsofstorm.net/bbkeys/${P}.tar.gz"
HOMEPAGE="http://movingparts.windsofstorm.net/code.shtml\#toolbox"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-wm/blackbox-0.61 
	=x11-libs/qt-2.3*"

src_compile() {

    QTDIR=/usr/qt/2 ./configure --prefix=/usr --host=${CHOST} || die
    emake || die

}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

