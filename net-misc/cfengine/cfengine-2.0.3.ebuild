# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header:

S=${WORKDIR}/${P}
DESCRIPTION="An agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${P}.tar.gz"
HOMEPAGE="http://www.iu.hio.no/cfengine/"

DEPEND="virtual/glibc
	=sys-libs/db-3.2*
	dev-libs/openssl"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	local myconf
	myconf="--with-berkeleydb=/usr"
	econf ${myconf} || die
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING DOCUMENTATION NEWS README SURVEY TODO
	dodoc doc/*.html
	doinfo doc/*.info*
        dodoc ${D}/usr/share/cfengine/*.example
        rm -rf ${D}/usr/share/cfengine ${D}/usr/doc
}
