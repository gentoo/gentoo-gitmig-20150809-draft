# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/atftp/atftp-0.6.ebuild,v 1.2 2002/09/21 02:40:21 vapier Exp $

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="ftp://ftp.mamalinux.com/pub/atftp/"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"
KEYWORDS="x86"
SRC_URI="ftp://ftp.mamalinux.com/pub/atftp/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack () {
	unpack ${A}
	cd ${S}

}

src_compile () {
	econf || die "./configure failed"

	cp Makefile Makefile.orig
	sed "s:CFLAGS = -g -Wall -D_REENTRANT -O2:CFLAGS = -g -Wall -D_REENTRANT ${CFLAGS}:" Makefile.orig >Makefile

	emake || die
}

src_install () {
	einstall || die "Installation failed"
}
