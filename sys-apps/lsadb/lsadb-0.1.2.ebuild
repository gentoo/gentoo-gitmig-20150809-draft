# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lsadb/lsadb-0.1.2.ebuild,v 1.1 2004/10/31 21:54:28 pylon Exp $

inherit eutils

DESCRIPTION="Prints out information on all devices attached to the ADB bus"
HOMEPAGE="http://pbbuttons.sourceforge.net/projects/lsadb/"
SRC_URI="http://pbbuttons.sourceforge.net/projects/lsadb/pkg/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc"
IUSE=""
DEPEND=""
RDEPEND="$DEPEND"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin lsadb
	doman lsadb.1
	dodoc README
}
