# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcl/pcl-1.4.ebuild,v 1.2 2005/05/18 04:24:33 mr_bones_ Exp $

DESCRIPTION="A library to provide low-level coroutines for in-process context switching"
HOMEPAGE="http://www.xmailserver.org/libpcl.html"
SRC_URI="http://www.xmailserver.org/lib${P}.tar.gz"

# license not specified, but derived from GPL'd works
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

src_unpack() {
	unpack ${A}
}

S="${WORKDIR}/lib${P}"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dolib pcl/.libs/libpcl.a
	dodoc ChangeLog INSTALL NEWS README
	dohtml man/pcl.html
	doman man/pcl.3
	insinto /usr/include
	doins include/pcl.h
}
