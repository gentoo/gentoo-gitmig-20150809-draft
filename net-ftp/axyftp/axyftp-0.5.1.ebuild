# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/axyftp/axyftp-0.5.1.ebuild,v 1.2 2004/01/27 21:10:52 mr_bones_ Exp $

DESCRIPTION="GUI FTP client for X Window System (former WXftp)"
SRC_URI="http://www.wxftp.seul.org/download/${P}.tar.gz"
HOMEPAGE="http://www.wxftp.seul.org"

LICENSE="Artistic LGPL-2.1"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-1.2"

src_compile(){
	econf || die "configure failed"
	emake -j1 || die "compilation failed"
}

src_install() {
	make install DESTDIR=${D}
}
