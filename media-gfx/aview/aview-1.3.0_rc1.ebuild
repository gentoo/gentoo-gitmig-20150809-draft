# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aview/aview-1.3.0_rc1.ebuild,v 1.1 2001/10/22 20:35:22 azarah Exp $

MY_P="`echo ${P} |sed -e 's:_::'`"
S="${WORKDIR}/`echo ${MY_P} |sed -e 's:rc.::'`"
DESCRIPTION="An ASCII PNG-Viewer"
SRC_URI="http://prdownloads.sourceforge.net/aa-project/${MY_P}.tar.gz"
HOMEPAGE="http://aa-project.sourceforge.net/aview/" 

DEPEND=">=media-libs/aalib-1.4_rc4"


src_compile() {

	./configure --prefix=/usr --host=${CHOST} || die
	make aview || die
}

src_install() {

	into /usr
	dobin aview asciiview
    
	doman *.1 
	dodoc ANNOUNCE COPYING ChangeLog README* TODO
}


