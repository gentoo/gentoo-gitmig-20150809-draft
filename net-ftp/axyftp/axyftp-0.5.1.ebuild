# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/axyftp/axyftp-0.5.1.ebuild,v 1.1 2004/01/27 19:47:04 mholzer Exp $

DESCRIPTION="GUI FTP client for X Window System (former WXftp)"
SRC_URI="http://www.wxftp.seul.org/download/${P}.tar.gz"
HOMEPAGE="http://www.wxftp.seul.org"

LICENSE="Artistic LGPL-2.1"
KEYWORDS="~x86 ~amd64"

DEPEND=">=x11-libs/gtk+-1.2"

src_compile(){
	econf || die "configure failed"
	emake -j1 || die "compilation failed"
}

src_install() {
	make install DESTDIR=${D}
}
