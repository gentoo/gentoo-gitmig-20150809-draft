# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-0.92.ebuild,v 1.4 2002/07/17 09:08:08 seemant Exp $

S=${WORKDIR}/${P}
SRC_URI="http://imcom.floobin.cx/files/${P}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyXML-0.7"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_install() {
	
	dodir /usr/bin
	dodir /usr/share/imcom
	dodoc AutoStatus.API CONTRIBUTORS LICENSE README* TODO WHATSNEW
	dodoc docs/*
	cp *.py ${D}/usr/share/imcom
	mv imcom imcom.orig
	sed -e 's:/usr/local/share:/usr/share:' imcom.orig | cat > imcom
	chmod 755 imcom 
	dobin imcom

}
