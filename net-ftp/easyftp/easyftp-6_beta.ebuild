# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/easyftp/easyftp-6_beta.ebuild,v 1.1 2002/05/27 00:58:52 rphillips Exp $

DESCRIPTION="An EASY GUI FTP Client (QT based)"
HOMEPAGE="http://freshmeat.net/projects/easyftp/"
LICENSE="GPL"
DEPEND="=x11-libs/qt-3*"
SRC_URI="http://backen.dyndns.org/files/easyFTPb6.tar"

S=${WORKDIR}

src_compile() {
	emake || die
}

src_install () {
	mkdir ${D}/usr/
	mkdir ${D}/usr/bin/
	cp ./easyFTP ${D}/usr/bin/
	dodoc README
}

