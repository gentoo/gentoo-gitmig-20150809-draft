# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sendfile/sendfile-2.1a.ebuild,v 1.4 2003/06/27 12:15:29 pylon Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Sendfile is a SAFT implementation for UNIX and serves as a tool for asynchronous sending of files in the Internet"
SRC_URI="ftp://ftp.belwue.de/pub/unix/sendfile/${P}.tar.gz"
HOMEPAGE="http://www.belwue.de/projekte/saft/sendfile-us.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	./makeconfig "CFLAGS=\"${CFLAGS}\" BINDIR=/usr/bin MANDIR=/usr/share/man \
		CONFIG=/etc/sendfile SERVERDIR=/usr/sbin" || die

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

	dodoc doc/AUTHORS doc/COPYING doc/ChangeLog doc/README* doc/THANKS
}

pkg_postinst() {
	einfo "To start the sendfile daemon you have to start Inetd."
	einfo
}
