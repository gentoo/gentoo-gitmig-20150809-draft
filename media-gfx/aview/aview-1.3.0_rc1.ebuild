# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aview/aview-1.3.0_rc1.ebuild,v 1.5 2002/08/09 18:09:47 gerk Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P/rc*/}
DESCRIPTION="An ASCII PNG-Viewer"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"
HOMEPAGE="http://aa-project.sourceforge.net/aview/" 

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/aalib-1.4_rc4"

src_compile() {

	econf || die
	make aview || die
}

src_install() {

	into /usr
	dobin aview asciiview
    
	doman *.1 
	dodoc ANNOUNCE COPYING ChangeLog README* TODO
}
