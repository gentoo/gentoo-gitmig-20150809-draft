# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/mosix-user/mosix-user-1.5.2.ebuild,v 1.4 2001/11/25 02:40:12 drobbins Exp

S=${WORKDIR}/openMosixUserland-${PV}
DESCRIPTION="User-land utilities for openMosix process migration (clustering) software"
SRC_URI="http://prdownloads.sourceforge.net/openmosix/openMosixUserland-${PV}.tgz"
HOMEPAGE="http://www.openmosix.com"
RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2"
DEPEND="$RDEPEND ~sys-kernel/openmosix-sources-2.4.17_pre3 sys-apps/findutils sys-devel/perl"

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
	#use perl, find and xargs to convert /usr/man references to /usr/share/man (FHS)
	find . -iname Makefile | xargs perl -pi.orig -e "s:INSTALLDIR\)/man:INSTALLDIR)/share/man:g"
}

src_compile() {
	cd ${S}
	make clean build man 
}

src_install () {
	make INSTALLDIR=${D}/usr install
	dodoc COPYING README
	exeinto /etc/init.d
	newexe ${FILESDIR}/openmosix.init openmosix
	insinto /etc
	#stub mosix.map file
	doins ${FILESDIR}/mosix.map
}

pkg_postinst() {
	echo
	echo " To complete openMosix installation, edit /etc/mosix.map and then type:
	echo "# rc-update add openmosix default
	echo " ...to add openMosix to the default runlevel.  This particular version of"
	echo " openmosix-user has been designed to work with the 2.4.17-pre3-openmosix"
	echo " kernel (sys-kernel/openmosix-sources-2.4.17_pre3.)"
	echo
}
