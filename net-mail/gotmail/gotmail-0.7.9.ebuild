# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.7.9.ebuild,v 1.2 2003/06/01 00:45:02 scandium Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://savannah.nongnu.org/download/${PN}/stable.pkg/${PV}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.nongnu.org/gotmail/"

RDEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"
DEPEND=${RDEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() { :; }

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
