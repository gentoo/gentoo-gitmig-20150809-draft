# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmmail/wmmail-0.64.ebuild,v 1.5 2002/08/02 17:54:50 seemant Exp $

DESCRIPTION="Mail checking dock applet for WindowMaker (mbox, POP3, IMAP, mh, and MailDir)"
HOMEPAGE="http://www.eecg.toronto.edu/cgi-bin/cgiwrap/chanb/index.cgi?wmmail"
WMMAIL_NAME="WMMail.app"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SRC_URI="http://www.eecg.utoronto.ca/~chanb/WMMail.app/WMMail.app-${PV}.tar.gz"
S="${WORKDIR}/WMMail.app-${PV}"

DEPEND="x11-base/xfree
	x11-libs/libPropList"

src_compile() {
	./configure \
		--host="${CHOST}" \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	cd "${S}"
	make DESTDIR="${D}" install || die
	dodir /usr/bin
	dosym /usr/lib/GNUstep/Apps/WMMail.app/WMMail /usr/bin/wmmail
	dodoc AUTHORS COPYING NEWS README doc/Help.txt
	mv doc/wmmail.man doc/wmmail.1
	doman doc/wmmail.1
}
