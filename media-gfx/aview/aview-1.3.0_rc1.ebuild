# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aview/aview-1.3.0_rc1.ebuild,v 1.3 2002/07/11 06:30:27 drobbins Exp $

MY_P="`echo ${P} |sed -e 's:_::'`"
S="${WORKDIR}/`echo ${MY_P} |sed -e 's:rc.::'`"
DESCRIPTION="An ASCII PNG-Viewer"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"
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


