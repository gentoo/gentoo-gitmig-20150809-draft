# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/openmosix-user/openmosix-user-0.2.4-r1.ebuild,v 1.2 2002/09/23 17:22:57 tantive Exp $

S=${WORKDIR}/openMosixUserland-${PV}
DESCRIPTION="User-land utilities for openMosix process migration (clustering) software"
SRC_URI="mirror://sourceforge/openmosix/openMosixUserland-${PV}.tgz"
HOMEPAGE="http://www.openmosix.com"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-kernel/openmosix-sources-2.4.18"
RDEPEND="${DEPEND}
	sys-apps/findutils
	sys-devel/perl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"


pkg_setup() {
    if [ -z "`readlink /usr/src/linux|grep openmosix`" ]; then 
    eerror
    eerror "Your linux kernel sources do not appear to be openmosix,"
    eerror "please check your /usr/src/linux symlink."
    eerror
    die
    fi
}

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
}

src_compile() {
	cd ${S}
	make clean build
}

src_install () {
	dodir /usr/lib
	dodir /usr/sbin
	dodir /usr/include
	dodir /usr/bin
	dodir /bin
	ln -s /usr/bin/migrate ${D}/bin/migrate
	ln -s /usr/bin/mmon ${D}/bin/mmon
	ln -s /usr/bin/mosctl ${D}/bin/mosctl
	ln -s /usr/bin/mosrun ${D}/bin/mosrun
	dodir /usr/share/man/man1
	make INSTALLBASEDIR=${D}usr \
		INSTALLMANDIR=${D}usr/share/man \
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
	einfo " openmosix-user has been designed to work with the linux-2.4.18-openmosix-r1"
	einfo " or later kernel (>=sys-kernel/openmosix-sources-2.4.18)"
	einfo
}
