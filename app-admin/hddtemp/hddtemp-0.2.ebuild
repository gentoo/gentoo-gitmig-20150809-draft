# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.2.ebuild,v 1.5 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A simple utility, to read the temperature of SMART IDE hard drives."
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

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
