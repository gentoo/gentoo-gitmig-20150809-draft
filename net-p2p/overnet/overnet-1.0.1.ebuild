# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/overnet/overnet-1.0.1.ebuild,v 1.1 2005/04/24 22:52:58 lanius Exp $

DESCRIPTION="Overnet is the successor of eDonkey2000 that allows you to share files with millions of other people across the globe."
HOMEPAGE="http://www.overnet.com"
SRC_URI="http://www.zen18864.zen.co.uk/overnet/${PV}/overnetclc-${PV}_i386.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install() {
	mv usr "${D}"
}

pkg_postinst() {
	einfo "From now on this is the overnet only core."
	einfo "For the edonkey/overnet hybrid core install net-p2p/edonkey"
}
