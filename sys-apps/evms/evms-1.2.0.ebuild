# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/evms/evms-1.2.0.ebuild,v 1.7 2003/06/21 21:19:39 drobbins Exp $

IUSE="ncurses gtk"

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
HOMEPAGE="http://www.sourceforge.net/projects/evms"

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

#EVMS uses libuuid from e2fsprogs
DEPEND="virtual/glibc gtk? ( =x11-libs/gtk+-1* ) ncurses? ( sys-libs/ncurses ) sys-apps/e2fsprogs"
KEYWORDS="x86 amd64 -ppc"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	local interfaces="CommandLine,utilities"
	use ncurses && interfaces="ncurses,${interfaces}"
	use gtk && interfaces="evmsgui,${interfaces}"

	cd engine
	./configure \
		--prefix=/usr \
		--libdir=/lib \
		--sbindir=/sbin \
		--with-plugins=all \
		--mandir=/usr/share/man \
		--includedir=/usr/include \
		--with-interfaces=${interfaces} \
		--host=${CHOST} || die "bad ./configure"
	#1.2.0 doesn't support parallel make
	make || die "compile problem"
}

src_install() {
	make -C engine DESTDIR=${D} install || die
	dodoc CHANGES COPYING EVMS*.txt PLUGIN.IDS

	# move static libraries to /usr/lib
	dodir /usr/lib
	mv -f ${D}/lib/*.a ${D}/usr/lib

	# realize these symlinks now so they get included
	cd ${D}/lib
	rm -f libdlist.so libevms.so
	ln -sf libevms-${PV}.so libevms.so.1
	ln -sf libevms.so.1 libevms.so
	ln -sf libdlist-1.0.so libdlist.so.1
	ln -sf libdlist.so.1 libdlist.so

	# the gtk+ frontend should live in /usr/sbin
	if [ -n "`use gtk`" ]
	then
		dodir /usr/sbin
		mv -f ${D}/sbin/evmsgui ${D}/usr/sbin
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/evms-init evms
}
