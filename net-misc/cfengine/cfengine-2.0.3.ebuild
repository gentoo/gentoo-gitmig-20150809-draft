# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-2.0.3.ebuild,v 1.12 2003/09/08 06:43:56 vapier Exp $

DESCRIPTION="An agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc
	=sys-libs/db-3.2*
	dev-libs/openssl"

src_compile() {
	econf --with-berkeleydb=/usr || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING DOCUMENTATION NEWS README SURVEY TODO
	dodoc doc/*.html
	doinfo doc/*.info*
	dodoc ${D}/usr/share/cfengine/*.example
	rm -rf ${D}/usr/share/cfengine ${D}/usr/doc
}
