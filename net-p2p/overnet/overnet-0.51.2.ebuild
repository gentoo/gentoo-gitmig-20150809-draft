# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-0.51.2.ebuild,v 1.2 2004/04/20 18:10:27 eradicator Exp $

IUSE=""

MY_P="${P/-/}"
S="${WORKDIR}"
DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://download.overnet.com/${MY_P}.tar.gz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install () {
	exeinto /usr/bin
	newexe ${MY_P} ${PN}
	dodoc README
}
