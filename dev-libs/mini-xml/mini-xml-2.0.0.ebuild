# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mini-xml/mini-xml-2.0.0.ebuild,v 1.2 2004/10/17 09:54:25 dholm Exp $

inherit libtool flag-o-matic gnuconfig


MY_P=${P/mini-xml-2.0.0/mxml-2.0}

DESCRIPTION="Mini-XML is a small XML parsing library that you can use to read XML and XML-like data files in your application without requiring large non-standard libraries."
HOMEPAGE="http://www.easysw.com/~mike/mxml"
SRC_URI="http://www.easysw.com/~mike/mxml/swfiles/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DSTROOT=${D} install || die "install failed"
	dodoc ANNOUNCEMENT CHANGES README TODO
}

