# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mini-xml/mini-xml-2.0.0.ebuild,v 1.5 2007/01/05 06:48:38 flameeyes Exp $

IUSE=""

inherit libtool flag-o-matic

MY_P=${P/mini-xml-2.0.0/mxml-2.0}

DESCRIPTION="Mini-XML is a small XML parsing library that you can use to read XML and XML-like data files in your application without requiring large non-standard libraries."
HOMEPAGE="http://www.easysw.com/~mike/mxml"
SRC_URI="http://www.easysw.com/~mike/mxml/swfiles/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_install() {
	make DSTROOT="${D}" install || die "install failed"
	dodoc ANNOUNCEMENT CHANGES README TODO
}
