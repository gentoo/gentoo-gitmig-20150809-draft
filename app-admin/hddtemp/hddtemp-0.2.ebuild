# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.2.ebuild,v 1.2 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A simple utility, to read the temperature of SMART IDE hard drives."

SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A} ; cd ${S}

	# patch hddtemp.c
	patch -p0 < ${FILESDIR}/hddtemp-0.2-db_location.patch

	# patch Makefile
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS=${CFLAGS} -DARCH_I386:" \
		-e "s:^CC.*:CC=gcc:" \
		Makefile.orig > Makefile

	# copy over hddtemp database file
	cp ${FILESDIR}/hddtemp.db ./
}

src_compile() {

	make || die

}

src_install () {

	exeinto /usr/bin
	doexe hddtemp
	dodir /usr/share/hddtemp
	insinto /usr/share/hddtemp
	doins hddtemp.db

	#docs
	dodoc README COPYING

}
