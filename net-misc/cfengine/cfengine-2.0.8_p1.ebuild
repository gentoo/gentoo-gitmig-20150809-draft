# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-2.0.8_p1.ebuild,v 1.2 2003/09/30 21:54:13 spyderous Exp $
PARCH=${P/_/}
DESCRIPTION="An agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${PARCH}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
DEPEND="virtual/glibc
	>=sys-libs/db-3.2
	dev-libs/openssl"

S="${WORKDIR}/${PARCH}"

src_compile() {
	econf \
		--sysconfdir=/etc/cfengine \
		--localstatedir=/var/lib/cfengine \
		--with-workdir=/var/lib/cfengine \
		--with-berkeleydb=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING DOCUMENTATION README TODO
	dohtml ${D}/usr/share/cfengine/html/*.html
	dodoc ${D}/usr/share/cfengine/*.example
	rm -rf ${D}/usr/share/cfengine ${D}/usr/doc
	mkdir -p ${D}/var/lib/cfengine
	fperms 700 /var/lib/cfengine
	keepdir /var/lib/cfengine/bin
	keepdir /var/lib/cfengine/inputs
	dosym /usr/sbin/cfagent /var/lib/cfengine/bin
}
