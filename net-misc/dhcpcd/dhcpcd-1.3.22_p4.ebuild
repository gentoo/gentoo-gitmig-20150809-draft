# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.22_p4.ebuild,v 1.9 2003/04/16 00:54:10 gmsoft Exp $

inherit gnuconfig

S=${WORKDIR}/${P/_p/-pl}
DESCRIPTION="A dhcp client only"
SRC_URI="ftp://ftp.phystech.com/pub/${P/_p/-pl}.tar.gz"
HOMEPAGE="http://www.phystech.com/download/"
DEPEND=""
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa arm mips"
LICENSE="GPL-2"
IUSE="build"

[ "${ARCH}" = "hppa" -o -z "${CBUILD}" ] && CBUILD="${CHOST}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	use alpha && gnuconfig_update

	#make the pidfile always goto /var/run (woodchip Dec 4 2002)
	cd ${S}
	cp client.c client.c.orig
	sed -e 's%\(PID_FILE_PATH,\)ConfigDir\(,IfNameExt\)%\1"/var/run"\2%' \
		client.c.orig >client.c
	cp signals.c signals.c.orig
	sed -e 's%\(PID_FILE_PATH,\)ConfigDir\(,IfNameExt\)%\1"/var/run"\2%' \
		signals.c.orig >signals.c
}

src_install () {
	einstall sbindir=${D}/sbin || die "Install failed"
	if [ -z "`use build`" ]
	then
		dodoc AUTHORS COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share
	fi
}
