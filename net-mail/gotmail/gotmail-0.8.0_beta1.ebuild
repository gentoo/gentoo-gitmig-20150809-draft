# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.0_beta1.ebuild,v 1.2 2004/03/24 23:20:22 mholzer Exp $

PVPREV=0.7.10
S=${WORKDIR}/${PN}-${PVPREV}
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://savannah.nongnu.org/download/${PN}/stable.pkg/${PV}/${PN}_${PVPREV}.tar.gz
		mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/gotmail/"

DEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

src_unpack() {
	unpack ${A}
	cp ${WORKDIR}/${PN} ${S}
}

src_compile() { :; }

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
