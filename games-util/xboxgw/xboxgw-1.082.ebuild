# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xboxgw/xboxgw-1.082.ebuild,v 1.1 2003/09/10 18:53:23 vapier Exp $

XBOXGW_P="${PN}-1.08-2"
HMLIBS_P="hmlibs-1.07-2"
DESCRIPTION="Tunnels XBox system link games over the net"
HOMEPAGE="http://www.xboxgw.com/"
SRC_URI="http://www.xboxgw.com/rel/dist2.1/tarballs/i386/${XBOXGW_P}.tgz
	http://www.xboxgw.com/rel/dist2.1/tarballs/i386/${HMLIBS_P}.i386.tgz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86"

S="${WORKDIR}"

src_install() {
	cd ${WORKDIR}/${HMLIBS_P}
	dolib.so *.so
	dobin hmdbdump
	insinto /usr/include/hmlibs
	doins *.h

	cd ${WORKDIR}/${XBOXGW_P}
	dobin xboxgw xbifsetup
	dodoc *.txt
}
