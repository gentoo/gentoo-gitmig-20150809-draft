# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.22_p4-r3.ebuild,v 1.3 2004/02/10 21:23:26 lostlogic Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="A dhcp client only"
HOMEPAGE="http://www.phystech.com/download/"
SRC_URI="ftp://ftp.phystech.com/pub/${P/_p/-pl}.tar.gz
	http://dev.gentoo.org/~drobbins/${P}.diff.bz2
	http://dev.gentoo.org/~drobbins/${P}-keepCacheAndResolv.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips ~amd64 ~ia64 ppc64"
IUSE="build static"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P/_p/-pl}

src_unpack() {
	unpack ${A} || die "unpack failed"
	use alpha && gnuconfig_update
	use amd64 && gnuconfig_update
	use hppa && gnuconfig_update
	use ia64 && gnuconfig_update

	cd ${S}
	#Started working on this patch from an older version I found; then
	#discovered that LFS had an updated one. We're using a patch that is
	#identical to theirs. It makes dhcpcd FHS-compliant. (drobbins, 06
	#Sep 2003)
	epatch ${DISTDIR}/${P}.diff.bz2
	#This next patch from Alwyn Schoeman <alwyn@smart.com.ph> is great;
	#it adds a -z (shutdown, keep cache) and various other little tweaks.
	#See http://bugs.gentoo.org/show_bug.cgi?id=23428 for more info.
	epatch ${DISTDIR}/${P}-keepCacheAndResolv.diff.bz2
	#This patch remove the iface down instruction from dhcpcd allowing us
	#to have physical iface scripts (gmsoft, 11 Nov 2003)
	epatch ${FILESDIR}/${P}-no-iface-down.diff
	#remove hard-coded arch stuff (drobbins, 06 Sep 2003)
	sed -i "s/ -march=i.86//g" configure
	sed -i 's:/etc/ntp\.drift:/var/lib/ntp/ntp.drift:' dhcpconfig.c
}

src_compile() {
	use static && append-flags -static

	./configure --prefix="" --sysconfdir=/var/lib --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	einstall sbindir=${D}/sbin || die "Install failed"
	rmdir ${D}/etc/dhcpc
	if [ -z "`use build`" ]
	then
		dodoc AUTHORS COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share
	fi
}
