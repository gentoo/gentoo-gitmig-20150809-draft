# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmail/wmmail-0.64-r2.ebuild,v 1.1 2003/05/21 20:30:28 joker Exp $

MY_PN=WMMail.app
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Mail checking dock applet for WindowMaker (mbox, POP3, IMAP, mh, and MailDir)"
HOMEPAGE="http://www.eecg.toronto.edu/cgi-bin/cgiwrap/chanb/index.cgi?wmmail"
SRC_URI="http://www.eecg.utoronto.ca/~chanb/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	x11-libs/libPropList"

src_compile() {
	econf --with-appspath=/usr/share/GNUstep || die
	emake || die
}

src_install () {
	# einstall fails with a sandbox violation
	make DESTDIR=${D} install
	dodir /usr/bin
	dosym /usr/share/GNUstep/${MY_PN}/WMMail /usr/bin/wmmail
	dodoc AUTHORS COPYING NEWS README doc/Help.txt
	newman/wmmail.man wmmail.1
}
