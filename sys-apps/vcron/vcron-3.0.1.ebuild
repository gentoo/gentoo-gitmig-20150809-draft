# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vcron/vcron-3.0.1.ebuild,v 1.3 2002/07/14 19:20:20 aliz Exp $

MY_P=${P/vcron/vixie-cron}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Vixie cron daemon"
SRC_URI="ftp://ftp.vix.com/pub/vixie/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linux-kheops.com/pub/vcron/vcronGB.html"
KEYWORDS="x86"
SLOT="0"
LICENSE=""

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${MY_P}-gentoo.patch || die

	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

	emake || die
}

src_install() {

	dodir /usr/{bin,sbin,share/man/man{1,5,8}}
	make DESTDIR=${D} \
		DESTMAN=${D}/usr/share/man \
		install || die

	dodoc CHANGES CONVERSION FEATURES MAIL MANIFEST README THANKS

	diropts -m0755 ; dodir /var/spool
	diropts -m0700 ; dodir /var/spool/cron
	diropts -m0755 ; dodir /etc/cron.d

	exeinto /etc/init.d
	newexe ${FILESDIR}/vcron.rc6 vcron
}

pkg_postinst() {

	if [ ! -d /var/spool/cron ] ; then
		mkdir -p /var/spool/cron
		chmod 0700 /var/spool/cron
	fi
	if [ ! -d /etc/cron.d ] ; then
		mkdir -p /etc/cron.d
		chmod 0755 /etc/cron.d
	fi
}

