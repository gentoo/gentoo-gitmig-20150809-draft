# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mdadm/mdadm-1.0.1.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="An extremely useful tool for running RAID systems - it can be used as a replacement for the raidtools, or as a supplement."
HOMEPAGE="http://www.cse.unsw.edu.au/~neilb/source"
SRC_URI="http://www.cse.unsw.edu.au/~neilb/source/mdadm/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="static"
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	mv Makefile Makefile.orig
	sed -e "33s:^CXFLAGS =:CXFLAGS = $CFLAGS:" Makefile.orig > Makefile

	if [ `use static` ]; then
		mv Makefile Makefile.orig
		echo "yes"
		sed \
			-e "39s:^# ::" \
			-e "40s:^# ::" \
			Makefile.orig > Makefile
	fi
}

src_compile() {
	make || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc INSTALL COPYING TODO ANNOUNCE

	insinto /etc
	newins mdadm.conf-example mdadm.conf
}
