# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/easyftp/easyftp-6_beta.ebuild,v 1.10 2004/07/14 23:55:09 agriffis Exp $

inherit eutils

S=${WORKDIR}
DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://freshmeat.net/projects/easyftp/"
SRC_URI="http://backen.dyndns.org/files/easyFTPb6.tar"

DEPEND="=x11-libs/qt-3*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64"
IUSE=""

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/easyftp-gcc3.2.diff
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe easyFTP
	dodoc README
}
