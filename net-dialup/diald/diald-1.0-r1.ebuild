# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/diald/diald-1.0-r1.ebuild,v 1.1 2002/05/04 03:20:58 woodchip Exp $

# You need SLIP in your kernel to run diald.

DESCRIPTION="Daemon that provides on demand IP links via SLIP or PPP"
HOMEPAGE="http://diald.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND="virtual/glibc sys-libs/pam sys-apps/tcp-wrappers"
RDEPEND="${DEPEND} net-dialup/ppp"
LICENSE="as-is"
SLOT="0"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/${P}-c-files.patch || die
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	dodir /etc/pam.d
	make \
		DESTDIR=${D} \
		sysconfdir=/etc \
		bindir=/usr/bin \
		sbindir=/usr/sbin \
		mandir=/usr/share/man \
		libdir=/usr/lib/diald \
		BINGRP=root \
		ROOTUID=root \
		ROOTGRP=root \
		install || die

	dodir /var/cache/diald
	mknod -m 0660 ${D}/var/cache/diald/diald.ctl p

	dodoc BUGS CHANGES LICENSE NOTES README* \
		THANKS TODO TODO.budget doc/diald-faq.txt
	docinto setup ; cp -a setup/* ${D}/usr/share/doc/${PF}/setup
	docinto contrib ; cp -a contrib/* ${D}/usr/share/doc/${PF}/contrib
	prepalldocs

	insinto /etc/diald ; doins ${FILESDIR}/{diald.conf,diald.filter}
	exeinto	/etc/init.d ; newexe ${FILESDIR}/diald-init diald
}
