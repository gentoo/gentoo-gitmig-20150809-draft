# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmail/wmmail-0.64.ebuild,v 1.2 2002/09/13 17:27:46 lostlogic Exp $

MY_PN=WMMail.app
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Mail checking dock applet for WindowMaker (mbox, POP3, IMAP, mh, and MailDir)"
HOMEPAGE="http://www.eecg.toronto.edu/cgi-bin/cgiwrap/chanb/index.cgi?wmmail"
SRC_URI="http://www.eecg.utoronto.ca/~chanb/${MY_PN}//${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	x11-libs/libPropList"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	cd "${S}"
	make DESTDIR="${D}" install || die
	dodir /usr/bin
	dosym /usr/lib/GNUstep/Apps/${MY_PN}/WMMail /usr/bin/wmmail
	dodoc AUTHORS COPYING NEWS README doc/Help.txt
	mv doc/wmmail.man doc/wmmail.1
	doman doc/wmmail.1
}
