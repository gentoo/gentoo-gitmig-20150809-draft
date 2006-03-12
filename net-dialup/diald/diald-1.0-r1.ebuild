# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/diald/diald-1.0-r1.ebuild,v 1.10 2006/03/12 10:05:59 mrness Exp $

# You need SLIP in your kernel to run diald.

inherit eutils

DESCRIPTION="Daemon that provides on demand IP links via SLIP or PPP"
HOMEPAGE="http://diald.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/pam
	sys-apps/tcp-wrappers"
RDEPEND="net-dialup/ppp"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-c-files.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
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
		DESTDIR="${D}" \
		sysconfdir=/etc \
		bindir=/usr/bin \
		sbindir=/usr/sbin \
		mandir=/usr/share/man \
		libdir=/usr/lib/diald \
		BINGRP=root \
		ROOTUID=root \
		ROOTGRP=root \
		install || die "make failed"

	dodir /var/cache/diald
	mknod -m 0660 "${D}/var/cache/diald/diald.ctl" p

	dodoc BUGS CHANGES LICENSE NOTES README* \
		THANKS TODO TODO.budget doc/diald-faq.txt
	docinto setup ; cp -pPR setup/* "${D}/usr/share/doc/${PF}/setup"
	docinto contrib ; cp -pPR contrib/* "${D}/usr/share/doc/${PF}/contrib"
	prepalldocs

	insinto /etc/diald ; doins "${FILESDIR}"/{diald.conf,diald.filter}
	newinitd "${FILESDIR}/diald-init" diald
}
