# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/nvemftp/nvemftp-0.1.3.ebuild,v 1.1 2004/03/20 14:41:04 centic Exp $

DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://nvemftp.sourceforge.net/"
SRC_URI="mirror://sourceforge/ftpcube/nvemftp/${P}.tar.gz"

DEPEND="=x11-libs/qt-3*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	make install INSTALL_ROOT="${D}usr/" || die
	dodoc README ChangeLog COPYING DESC AUTHORS TODO BUGS || die
}

