# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nc6/nc6-0.5.ebuild,v 1.1 2003/06/02 15:39:41 latexer Exp $

DESCRIPTION="Version of netcat that supports both IPv6 and IPv4"
HOMEPAGE="http://netcat6.sourceforge.net"
SRC_URI="http://ftp.deepspace6.net/pub/sources/nc6/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="nls"
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	
	dodoc AUTHORS BUGS README NEWS TODO CREDITS ChangeLog
}
