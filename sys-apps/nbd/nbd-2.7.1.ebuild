# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-2.7.1.ebuild,v 1.1 2004/06/20 05:26:52 vapier Exp $

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/glibc
	app-text/docbook-sgml-utils"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" gznbd/Makefile
	sed -i 's:docbook-to-man:docbook2man:g' Makefile.in
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
