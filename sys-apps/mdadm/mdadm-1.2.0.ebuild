# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mdadm/mdadm-1.2.0.ebuild,v 1.8 2004/07/15 01:48:38 agriffis Exp $

DESCRIPTION="An extremely useful tool for running RAID systems - it can be used as a replacement for the raidtools, or as a supplement."
HOMEPAGE="http://www.cse.unsw.edu.au/~neilb/source"
SRC_URI="http://www.cse.unsw.edu.au/~neilb/source/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 alpha"
IUSE="static"
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	mv Makefile Makefile.orig
	sed -e "36s:^CXFLAGS =:CXFLAGS = $CFLAGS:" Makefile.orig > Makefile

	if use static; then
		mv Makefile Makefile.orig
		echo "yes"
		sed \
			-e "42s:^# ::" \
			-e "43s:^# ::" \
			Makefile.orig > Makefile
	fi
}

src_compile() {
	make || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc INSTALL COPYING TODO ANNOUNCE-${PV}

	insinto /etc
	newins mdadm.conf-example mdadm.conf
}
