# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.7.1-r1.ebuild,v 1.1 2002/06/14 21:15:48 g2boojum Exp $

DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://ssl.usu.edu/paul/gotmail/${PN}_${PV}.tar.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gotmail/"
S=${WORKDIR}/${P}
RDEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"
DEPEND=${RDEPEND}
LICENSE="GPL-2"
SLOT="0"

src_compile() { :; }

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
