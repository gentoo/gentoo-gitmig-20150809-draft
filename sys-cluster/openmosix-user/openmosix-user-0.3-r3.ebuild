# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosix-user/openmosix-user-0.3-r3.ebuild,v 1.2 2003/05/08 22:42:20 tantive Exp $

S=${WORKDIR}/openmosix-tools-${PV}
DESCRIPTION="User-land utilities for openMosix process migration (clustering) software"
SRC_URI="mirror://sourceforge/openmosix/openmosix-tools-${PV}.tgz"
HOMEPAGE="http://www.openmosix.com/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-kernel/openmosix-sources-2.4.18"
RDEPEND="${DEPEND}
	sys-apps/findutils
	dev-lang/perl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha"

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
CFLAGS=-I/m/include -I./ -I/usr/include -I\${OPENMOSIX}/include -I${S}/moslib ${CFLAGS}
INSTALL=/usr/bin/install
EOF
}

src_compile() {
	cd ${S}
	make clean build
}

src_install() {
	dodir /bin
	dodir /sbin
	dodir /usr/share/doc
	dodir /usr/share/man/man1
	make INSTALLDIR=${D}/usr \
		MANDIR=${D}usr/share/man \
		SYSCONFDIR=${D}/etc \
		BINDIR=${D}/bin \
		SBINDIR=${D}/sbin \
		RCDIR=${D}/etc/init.d \
		LIBDIR=${D}/usr/lib \
		install

	dodoc COPYING README
	rm ${D}/etc/init.d/openmosix
	exeinto /etc/init.d
	newexe ${FILESDIR}/openmosix.init openmosix
	insinto /etc
	rm ${D}/etc/openmosix.map
	#Test if mosix.map is present, stub appropriate openmosix.map
	#file
	if test -e /etc/openmosix.map; then
	    einfo "Seems you already have a openmosix.map file, using it.";
	elif test -e /etc/mosix.map; then
        	cp /etc/mosix.map ${WORKDIR}/openmosix.map;
		doins ${WORKDIR}/openmosix.map;
	else
		doins ${FILESDIR}/openmosix.map;
	fi
}

pkg_postinst() {
	einfo
	einfo " To complete openMosix installation, edit /etc/openmosix.map or"
	einfo " delete it to use autodiscovery  and then type:"
	einfo " # rc-update add openmosix default"
	einfo " ...to add openMosix to the default runlevel.  This particular version of"
	einfo " openmosix-user has been designed to work with the linux-2.4.18-openmosix-1"
	einfo " or later kernel (>=sys-kernel/openmosix-sources-2.4.18)"
	einfo
}
