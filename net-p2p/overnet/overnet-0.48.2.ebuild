# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-0.48.2.ebuild,v 1.4 2004/03/01 06:26:59 eradicator Exp $

MY_P="${P/-/}"
S="${WORKDIR}"
DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://www.overnet.com/files/${MY_P}.tar.gz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_install () {
	cp ${MY_P} ${PN}
	dodir /opt/${PN}
	exeinto /opt/${PN}
	doexe ${PN}
	#chown root.root ${D}/${I}/overnet
	#chmod 755 ${D}/${I}/overnet
}
