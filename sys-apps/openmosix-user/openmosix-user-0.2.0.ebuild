# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/openmosix-user/openmosix-user-0.2.0.ebuild,v 1.3 2002/07/21 20:34:45 gerk Exp $

S=${WORKDIR}/openMosixUserland-${PV}
DESCRIPTION="User-land utilities for openMosix process migration (clustering) software"
SRC_URI="mirror://sourceforge/openmosix/openMosixUserland-${PV}.tar.gz"
HOMEPAGE="http://www.openmosix.com"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-kernel/openmosix-sources-2.4.17"
RDEPEND="${DEPEND}
	sys-apps/findutils
	sys-devel/perl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cat > configuration << EOF
OPENMOSIX=/usr/src/linux
PROCDIR=/proc/hpc
MONNAME=mmon
CC=gcc
INSTALLDIR=/usr
CFLAGS=-I/m/include -I./ -I/usr/include -I\$(OPENMOSIX)/include ${CFLAGS}
INSTALL=/usr/bin/install
EOF
#	#use perl, find and xargs to convert /usr/man references to /usr/share/man (FHS)
#	find . -iname Makefile | xargs perl -pi.orig -e "s:INSTALLDIR\)/man:INSTALLDIR)/share/man:g"
}

src_compile() {
	cd ${S}
	make clean build
}

src_install () {
	sed -e "s:INSTALLEXTRADIR:INSTALLBASEDIR:" moslib/Makefile > moslib/Makefile.hacked
	mv moslib/Makefile.hacked moslib/Makefile
	dodir /usr/lib
	dodir /usr/sbin
	dodir /usr/include
	dodir /usr/bin
	dodir /usr/share/man/man1
	make INSTALLBASEDIR=${D}usr \
		INSTALLEXTRADIR=${D}usr/share \
		DESTDIR=${D} \
		INSTALLDIR=${D}usr \
		install

	dodoc COPYING README
	exeinto /etc/init.d
	newexe ${FILESDIR}/openmosix.init openmosix
	insinto /etc
	#stub mosix.map file
	doins ${FILESDIR}/mosix.map
}

pkg_postinst() {
	einfo
	einfo " To complete openMosix installation, edit /etc/mosix.map and then type:
	einfo "# rc-update add openmosix default
	einfo " ...to add openMosix to the default runlevel.  This particular version of"
	einfo " openmosix-user has been designed to work with the linux-2.4.17-openmosix-r1"
	einfo " or later kernel (>=sys-kernel/openmosix-sources-2.4.17)"
	einfo
}
