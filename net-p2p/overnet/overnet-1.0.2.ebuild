# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-1.0.2.ebuild,v 1.3 2004/10/27 15:08:55 lanius Exp $

DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://www.zen18864.zen.co.uk/edonkey/${PV}/edonkeyclc-${PV}_i386.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 -ppc"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install() {
	mv usr "${D}"
}
