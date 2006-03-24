# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/nvemftp/nvemftp-0.1.3.ebuild,v 1.5 2006/03/24 13:33:39 caleb Exp $

inherit kde

DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://nvemftp.sourceforge.net/"
SRC_URI="mirror://sourceforge/nvemftp/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE=""

need-qt 3

src_compile() {
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake nvemftp.pro
	emake || die
}

src_install() {
	make install INSTALL_ROOT="${D}usr/" || die
	dodoc README ChangeLog COPYING DESC AUTHORS TODO BUGS || die
}

