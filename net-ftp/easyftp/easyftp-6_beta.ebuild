# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/easyftp/easyftp-6_beta.ebuild,v 1.2 2002/07/17 09:39:57 seemant Exp $

S=${WORKDIR}
DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://freshmeat.net/projects/easyftp/"
SRC_URI="http://backen.dyndns.org/files/easyFTPb6.tar"

DEPEND="=x11-libs/qt-3*"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin/
	doexe easyFTP
	dodoc README
}

