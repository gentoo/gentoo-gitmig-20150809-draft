# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/atlas-c++/atlas-c++-0.4.6.ebuild,v 1.2 2004/03/19 07:56:03 mr_bones_ Exp $

MY_PN="Atlas-C++"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Atlas protocol standard implementation in C++.  Atlas protocol is used in role playing games at worldforge."
HOMEPAGE="http://www.worldforge.net"
SRC_URI="ftp://ftp.worldforge.org/pub/worldforge/libs/${MY_PN}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=dev-libs/libsigc++-1.2*"

src_compile() {

	econf || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die
	#dodoc will install all these docs and a few more
	rm -rf ${D}/usr/share/doc/${My_P}
	#PR=r0 in this case, but don't fprget to add ${PR} here for non-zero revisions!

	dodoc AUTHORS COPYING ChangeLog NEWS README ROADMAP THANKS TODO
}
