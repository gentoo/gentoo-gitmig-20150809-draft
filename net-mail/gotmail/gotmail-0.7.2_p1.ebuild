# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.7.2_p1.ebuild,v 1.2 2002/07/17 04:20:40 seemant Exp $

PV0=0.7.2
PDP=1
S=${WORKDIR}/${PN}-${PV0}
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PV0}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PV0}-${PDP}.diff.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gotmail/"

RDEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"
DEPEND=${RDEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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
