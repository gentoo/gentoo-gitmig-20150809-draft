# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/edonkey/edonkey-1.3.0.ebuild,v 1.1 2005/07/05 11:43:16 lanius Exp $

DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://www.zen18864.zen.co.uk/edonkey/${PV}/edonkeyclc_${PV}_i386.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install() {
	mv usr "${D}"
}
