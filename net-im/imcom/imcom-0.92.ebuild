# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-0.92.ebuild,v 1.3 2002/07/11 06:30:46 drobbins Exp $

S=${WORKDIR}/${P}
DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyXML-0.7"
SLOT="0"
SRC_URI="http://imcom.floobin.cx/files/${P}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

src_install() {
	
	cd ${S}
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/imcom
        mkdir -p ${D}/usr/share/imcom/docs
        cp AutoStatus.API CONTRIBUTORS LICENSE README README.autostatus TODO WHATSNEW ${D}/usr/share/imcom/docs       
	cp docs/* ${D}/usr/share/imcom/docs
        cp *.py ${D}/usr/share/imcom
	mv imcom imcom.orig
	sed -e 's:/usr/local/share:/usr/share:' imcom.orig | cat > imcom
	chmod 755 imcom 
        cp imcom ${D}/usr/bin

}
