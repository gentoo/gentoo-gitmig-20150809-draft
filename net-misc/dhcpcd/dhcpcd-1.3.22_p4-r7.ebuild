# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.22_p4-r7.ebuild,v 1.1 2004/11/04 18:06:39 vapier Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="A dhcp client only"
HOMEPAGE="http://www.phystech.com/download/"
SRC_URI="ftp://ftp.phystech.com/pub/${P/_p/-pl}.tar.gz
	http://dev.gentoo.org/~drobbins/${P}.diff.bz2
	http://dev.gentoo.org/~drobbins/${P}-keepCacheAndResolv.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="build static"

DEPEND="virtual/libc"
PROVIDE="virtual/dhcpc"

S=${WORKDIR}/${P/_p/-pl}

src_unpack() {
	unpack ${A}
	gnuconfig_update

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
	econf --prefix=/ || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	rm -rf "${D}"/etc
	if ! use build ; then
		dodoc AUTHORS ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share
	fi
}
