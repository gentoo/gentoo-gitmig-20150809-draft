# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.13-r1.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/ifplugd"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND=""
#RDEPEND=""

S=${WORKDIR}/ifplugd

src_unpack() {
	unpack ${A}

	cd ${S}
	perl -pi.orig -e 's:^CFLAGS=.*$:CFLAGS='"${CFLAGS}:" Makefile
	perl -pi.orig -e 's:/etc/ifplugd/ifplugd.action:/usr/sbin/ifplugd.action:' ifplugd.c
}

src_compile() {
	emake
}

src_install() {
	dosbin ifplugd ${FILESDIR}/ifplugd.action ifstatus
	doman ifplugd.8 ifstatus.8

	dodir /etc/conf.d
	mv ifplugd.conf ${D}/etc/conf.d/ifplugd
	
	exeinto /etc/init.d
	doexe ${FILESDIR}/ifplugd

	dodoc README SUPPORTED_DRIVERS FAQ NEWS
}
