# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreen/tcpreen-1.2.4.ebuild,v 1.1 2003/12/01 07:13:20 vapier Exp $

DESCRIPTION="TCP network re-engineering tool"
HOMEPAGE="http://www.simphalempin.com/dev/tcpreen/"
SRC_URI="mirror://sourceforge/tcpreen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS NEWS THANKS TODO README
}
