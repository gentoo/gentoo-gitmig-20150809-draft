# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-2.7.1.ebuild,v 1.7 2004/11/02 06:25:18 vapier Exp $

inherit eutils

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz
	mirror://gentoo/nbd-linux-include.h.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/libc
	app-text/docbook-sgml-utils"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" gznbd/Makefile
	epatch ${FILESDIR}/docbook2man.patch
	if [ -z "`grep NBD_CMD_DISC ${ROOT}/usr/include/linux/nbd.h`" ] ; then
		mkdir linux
		mv ../nbd-linux-include.h linux/nbd.h
	fi
}

src_compile() {
	econf \
		--enable-lfs \
		--enable-syslog \
		|| die
	emake || die
	emake -C gznbd || die
}

src_install() {
	make install DESTDIR=${D} || die
	dobin gznbd/gznbd || die
	dodoc README
}
