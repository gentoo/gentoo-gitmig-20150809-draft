# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/evms/evms-1.1.0.ebuild,v 1.2 2002/08/27 04:34:35 woodchip Exp $

# You need to have an evms-patched kernel source tree in /usr/src/linux
# to build these programs.  Either take care of that yourself, or apply
# the patches inside the tarball against a current vanilla linux kernel.

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
HOMEPAGE="http://www.sourceforge.net/projects/evms"
KEYWORDS="x86 -ppc"

NEWP=evms-1.1.0
LIBV=1.1.0
S=${WORKDIR}/${NEWP}
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/${PN}/${NEWP}.tar.gz"

#EVMS uses libuuid from e2fsprogs
DEPEND="virtual/glibc gtk? ( =x11-libs/gtk+-1* ) ncurses? ( sys-libs/ncurses ) sys-apps/e2fsprogs"
RDEPEND="${DEPEND}"
LICENSE="GPL-2"
SLOT="0"

pkg_setup() {
	if [ ! -f /usr/src/linux/include/linux/evms/evms.h ]
	then
		eerror "You dont appear to have an evms-patched kernel source"
		eerror "tree in /usr/src/linux. Please fix that and try again."
		return 1
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	#this next patch fixes some missing libuuid symbols:
	#patch -p1 < ${FILESDIR}/${NEWP}-gcc31.diff || die
	#this next patch allows EVMS to recognize the new ReiserFS 3.6 versioning scheme
	#patch -p1 < ${FILESDIR}/${NEWP}-reiserfs-3.6.diff || die
}

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
		--with-kernel=/usr/src/linux \
		--with-interfaces=${interfaces} \
		--host=${CHOST} || die "bad ./configure"
	#1.1.0 doesn't support parallel make
	make || die "compile problem"
}

src_install() {
	make -C engine DESTDIR=${D} install || die
	dodoc CHANGES COPYING EVMS*.txt PLUGIN.IDS

	# move static libraries to /usr/lib
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib

	# realize these symlinks now so they get included
	cd ${D}/lib
	rm -f libdlist.so libevms.so
	ln -sf libevms-${LIBV}.so libevms.so.1
	ln -sf libevms.so.1 libevms.so
	ln -sf libdlist-1.0.so libdlist.so.1
	ln -sf libdlist.so.1 libdlist.so

	# the gtk+ frontend should live in /usr/sbin
	if [ -n "`use gtk`" ]
	then
		dodir /usr/sbin
		mv ${D}/sbin/evmsgui ${D}/usr/sbin
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/evms-init evms
}
