# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/atftp/atftp-0.6-r3.ebuild,v 1.6 2004/12/04 14:01:42 dsd Exp $

inherit eutils

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="ftp://ftp.mamalinux.com/pub/atftp/"
SRC_URI="ftp://ftp.mamalinux.com/pub/atftp/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="x86"
IUSE="tcpd"
SLOT="0"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!virtual/tftp"

PROVIDE="virtual/tftp"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_compile () {
	myconf=""
	use tcpd && myconf="${myconf} --enable-libwrap" \
		|| myconf="${myconf} --disable-libwrap"

	econf ${myconf} || die "./configure failed"

	cp Makefile Makefile.orig
	sed "s:CFLAGS = -g -Wall -D_REENTRANT -O2:CFLAGS = -g -Wall -D_REENTRANT ${CFLAGS}:" Makefile.orig >Makefile

	emake || die
}

src_install () {
	einstall || die "Installation failed"
}
