# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/nvemftp/nvemftp-0.1.3.ebuild,v 1.8 2007/07/15 02:38:18 mr_bones_ Exp $

inherit kde

DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://nvemftp.sourceforge.net/"
SRC_URI="mirror://sourceforge/nvemftp/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-amd64 ~sparc ~x86"
IUSE=""

PATCHES="${FILESDIR}/${P}+qt-3.3.5.patch"

need-qt 3

src_compile() {
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake nvemftp.pro
	emake || die
}

src_install() {
	make install INSTALL_ROOT="${D}usr/" || die
	dodoc README ChangeLog COPYING DESC AUTHORS TODO BUGS || die
}
