# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/secpanel/secpanel-0.41.ebuild,v 1.1 2003/10/30 11:19:57 taviso Exp $

DESCRIPTION="X11 Frontend for OpenSSH"
HOMEPAGE="http://www.pingx.net/secpanel/"

SRC_URI="http://www.pingx.net/secpanel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~alpha"
IUSE=""

DEPEND=""

RDEPEND="virtual/ssh dev-lang/tk"

S=${WORKDIR}/${P}

src_install() {
	dobin ${S}/src/bin/secpanel
	dodir /usr/lib/secpanel /usr/lib/secpanel/images

	insinto /usr/lib/secpanel
	doins ${S}/src/lib/secpanel/*.{tcl,config,profile,dist,wait}

	insinto /usr/lib/secpanel/images
	doins ${S}/src/lib/secpanel/images/*.gif

	fperms 755 /usr/lib/secpanel/{listserver.tcl,secpanel.dist,secpanel.wait}

	dodoc CHANGES COPYING README
}
