# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dclib/dclib-0.2_rc4.ebuild,v 1.1 2003/01/02 00:49:40 vapier Exp $

inherit gcc

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Library for the Qt client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-apps/bzip2-1.0.2
        >=dev-libs/libxml2-2.4.22"

src_compile() {
	export CPPFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"
	if [ `gcc-major-version` == 2 ] ; then
		patch -p0 < ${FILESDIR}/${P}-gcc2.patch || die
	fi
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
