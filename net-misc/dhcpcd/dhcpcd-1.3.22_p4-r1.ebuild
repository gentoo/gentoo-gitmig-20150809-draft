# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.22_p4-r1.ebuild,v 1.2 2003/09/07 00:47:37 drobbins Exp $

inherit gnuconfig

S=${WORKDIR}/${P/_p/-pl}
DESCRIPTION="A dhcp client only"
SRC_URI="ftp://ftp.phystech.com/pub/${P/_p/-pl}.tar.gz http://dev.gentoo.org/~drobbins/${P}.diff.bz2 http://dev.gentoo.org/~drobbins/${P}-keepCacheAndResolv.diff.bz2"
HOMEPAGE="http://www.phystech.com/download/"
DEPEND=""
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa arm mips amd64"
LICENSE="GPL-2"
IUSE="build"

[ "${ARCH}" = "hppa" -o -z "${CBUILD}" ] && CBUILD="${CHOST}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	use alpha && gnuconfig_update
	use amd64 && gnuconfig_update

	cd ${S}
	#Started working on this patch from an older version I found; then
	#discovered that LFS had an updated one. We're using a patch that is
	#identical to theirs. It makes dhcpcd FHS-compliant. (drobbins, 06
	#Sep 2003)
	cat ${DISTDIR}/${P}.diff.bz2 | bzip2 -d | patch -p1 || die
	#This next patch from Alwyn Schoeman <alwyn@smart.com.ph> is great;
	#it adds a -z (shutdown, keep cache) and various other little tweaks.
	#See http://bugs.gentoo.org/show_bug.cgi?id=23428 for more info.
	cat ${DISTDIR}/${P}-keepCacheAndResolv.diff.bz2 | bzip2 -d | patch -p1 || die
	#remove hard-coded arch stuff (drobbins, 06 Sep 2003)
	local x
	x=configure
	cp ${x} ${x}.orig
	sed -e "s/ -march=i.86//g" ${x}.orig > ${x} || die
}

src_compile() {
	./configure --prefix="" --sysconfdir=/var/lib --mandir=/usr/share/man || die
	emake || die
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
