# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/easyftp/easyftp-6_beta.ebuild,v 1.7 2003/02/13 14:03:18 vapier Exp $

S=${WORKDIR}
DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://freshmeat.net/projects/easyftp/"
SRC_URI="http://backen.dyndns.org/files/easyFTPb6.tar"

DEPEND="=x11-libs/qt-3*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	patch -p0<${FILESDIR}/easyftp-gcc3.2.diff
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe easyFTP
	dodoc README
}

