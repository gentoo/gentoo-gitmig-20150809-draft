# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulog-acctd/ulog-acctd-0.4.2.ebuild,v 1.1 2004/07/24 18:16:51 liquidx Exp $

inherit eutils

DESCRIPTION="ULOG-based accounting daemon with flexible log-format"
SRC_URI="http://alioth.debian.org/download.php/604/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://savannah.nongnu.org/projects/ulog-acctd/ http://alioth.debian.org/projects/pkg-ulog-acctd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-firewall/iptables"

S=${WORKDIR}/${PN}-${PV}.orig

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-gcc2.patch
}

src_compile() {
	cd ${S}/src || die "cannot change to src-directory"
	make || die "compile of pgm failed"
	cd ${S}/doc || die "cannot change to doc-directory"
	make || die "compile of docu failed"
}

src_install() {
	dosbin src/ulog-acctd

	insinto /etc/
	doins src/ulog-acctd.conf

	doman doc/ulog-acctd.8
	doinfo doc/ulog-acctd.info

	## install contrib-dir in /usr/share/doc/${P}:
	docinto contrib/pg_load
	dodoc contrib/pg_load/*

	docinto contrib/ulog-acctd2mrtg
	dodoc contrib/ulog-acctd2mrtg/*

	keepdir /var/log/ulog-acctd
}

pkg_postinst() {
	einfo "ulog-acctd get's it's packages via ULOG-targets in your iptables-rules."
}
