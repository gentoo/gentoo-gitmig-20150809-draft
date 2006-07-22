# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/nvemftp/nvemftp-0.1.3.ebuild,v 1.6 2006/07/22 09:46:46 blubb Exp $

inherit kde

DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://nvemftp.sourceforge.net/"
SRC_URI="mirror://sourceforge/nvemftp/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-amd64 ~sparc ~x86"
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

