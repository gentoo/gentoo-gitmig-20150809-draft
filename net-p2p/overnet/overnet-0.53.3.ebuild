# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-0.53.3.ebuild,v 1.2 2004/06/08 20:37:07 dholm Exp $

IUSE=""

MY_PV=${PV}-tim
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://download.overnet.com/${PN}-${MY_PV}.tar.gz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 -ppc"

DEPEND="virtual/glibc"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install () {
	exeinto /usr/bin
	newexe ${PN}${MY_PV} ${PN}
	dodoc README
}
