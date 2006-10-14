# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sendfile/sendfile-2.1a.ebuild,v 1.10 2006/10/14 21:51:59 tester Exp $

DESCRIPTION="SAFT implementation for UNIX and serves as a tool for asynchronous sending of files in the Internet"
HOMEPAGE="http://www.belwue.de/projekte/saft/sendfile-us.html"
SRC_URI="ftp://ftp.belwue.de/pub/unix/sendfile/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

src_compile() {
	./makeconfig \
		"CFLAGS=\"${CFLAGS}\" \
		BINDIR=/usr/bin \
		MANDIR=/usr/share/man \
		CONFIG=/etc/sendfile \
		SERVERDIR=/usr/sbin" || die

	make all || die
}

src_install() {
	into /usr
	dosbin src/sendfiled
	dobin etc/check_sendfile src/sendfile src/sendmsg src/receive src/fetchfile
	dobin src/utf7encode src/wlock etc/sfconf etc/sfdconf
	dosym /usr/bin/utf7encode /usr/bin/utf7decode

	dodir /etc/sendfile
	dodir /var/spool/sendfile
	dodir /var/spool/sendfile/LOG
	dodir /var/spool/sendfile/OUTGOING
	fperms 0700 /var/spool/sendfile/LOG
	fperms 1777 /var/spool/sendfile/OUTGOING

	insinto /etc/sendfile
	doins etc/sendfile.deny etc/sendfile.cf

	doman doc/sendmsg.1 doc/sendfile.1 doc/receive.1 doc/fetchfile.1

	dodoc doc/AUTHORS doc/ChangeLog doc/README* doc/THANKS
}

pkg_postinst() {
	einfo "To start the sendfile daemon you have to start Inetd."
}
