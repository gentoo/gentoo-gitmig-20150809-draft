# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/cec/cec-8.ebuild,v 1.4 2009/09/23 20:29:49 patrick Exp $

DESCRIPTION="Coraid Ethernet Console client"
HOMEPAGE="http://sf.net/projects/aoetools/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
		sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd "${S}"
}
src_compile() {
	emake -f makefile || die "emake failed"
}

src_install() {
	dodir /usr/sbin
	cp "${S}"/cec "${D}"/usr/sbin

	doman cec.8
}
