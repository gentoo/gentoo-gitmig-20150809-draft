# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/jftpgw/jftpgw-0.13.1.ebuild,v 1.3 2003/06/25 22:20:11 vapier Exp $

DESCRIPTION="A small FTP gateway"
HOMEPAGE="http://www.mcknight.de/jftpgw/"
SRC_URI="http://www.mcknight.de/jftpgw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf \
		--sysconfdir=${D}/etc/jftpgw \
		--with-logpath=${D}/etc/jftpgw \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING README TODO
}
