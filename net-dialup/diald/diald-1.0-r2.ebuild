# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/diald/diald-1.0-r2.ebuild,v 1.1 2007/07/12 07:36:27 mrness Exp $

inherit eutils autotools

DESCRIPTION="Daemon that provides on demand IP links via SLIP or PPP"
HOMEPAGE="http://diald.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE="pam"

DEPEND="pam? ( sys-libs/pam )
	sys-apps/tcp-wrappers"
RDEPEND="${DEPEND}
	net-dialup/ppp"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-posix.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	if ! use pam; then
		epatch "${FILESDIR}/${P}-nopam.patch"
		cd "${S}"
		eautoconf
	fi
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
