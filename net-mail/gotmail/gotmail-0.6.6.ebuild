# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.6.6.ebuild,v 1.2 2001/10/21 19:00:47 g2boojum Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://www.hawkins.emu.id.au/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.hawkins.emu.id.au/gotmail/"

DEPEND="net-ftp/curl
	dev-perl/URI"

src_compile() {
	echo "Nothing to compile"
}

src_install () {
	dobin gotmail.pl
	dodoc COPYING ChangeLog README TODO sample.gotmailrc
}
