# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mdadm/mdadm-1.5.0.ebuild,v 1.1 2004/01/30 04:35:24 robbat2 Exp $

DESCRIPTION="An extremely useful tool for running RAID systems - it can be used as a replacement for the raidtools, or as a supplement."
HOMEPAGE="http://www.cse.unsw.edu.au/~neilb/source"
SRC_URI="http://www.cse.unsw.edu.au/~neilb/source/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha"
IUSE="static"
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ `use static` ]; then
		sed \
			-e "44s:^# ::" \
			-e "45s:^# ::" \
			Makefile.orig > Makefile
	fi
}

src_compile() {
	make CXFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc INSTALL COPYING TODO ANNOUNCE-${PV}

	insinto /etc
	newins mdadm.conf-example mdadm.conf
}
