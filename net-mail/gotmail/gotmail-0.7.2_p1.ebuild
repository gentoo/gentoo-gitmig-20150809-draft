# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.7.2_p1.ebuild,v 1.1 2002/07/04 16:26:33 g2boojum Exp $

PV0=0.7.2
PDP=1
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PV0}.orig.tar.gz
		 http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PV0}-${PDP}.diff.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gotmail/"
S=${WORKDIR}/${PN}-${PV0}
RDEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"
DEPEND=${RDEPEND}
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${PN}_${PV0}.orig.tar.gz
	zcat ${DISTDIR}/${PN}_${PV0}-${PDP}.diff.gz | patch -d ${S} -p1 || die
}

src_compile() { :; }

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
