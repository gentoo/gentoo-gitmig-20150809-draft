# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-1.0.2.ebuild,v 1.1 2004/09/11 16:20:33 lanius Exp $

IUSE=""

S=${WORKDIR}

DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://www.zen18864.zen.co.uk/edonkey/${PV}/edonkeyclc-${PV}_i386.tgz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 -ppc"

DEPEND="virtual/glibc"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install () {
	mv usr ${D}
}
