# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.83.ebuild,v 1.5 2002/09/21 03:48:54 vapier Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="System initialization stuff"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/init/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="$DEPEND sys-apps/file"
HOMEPAGE="http://freshmeat.net/projects/sysvinit/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

src_unpack() {

	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {

	emake LDFLAGS="" || die "problem compiling"
}

src_install() {

	into /
	newsbin init init.system
	dosbin halt killall5 runlevel shutdown sulogin
	dosym init /sbin/telinit
	dobin last mesg utmpdump wall
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot

	doman man/*.[1-9]

	dodoc README doc/*
}

pkg_postinst() {

	if [ ! -e ${ROOT}sbin/init ]
	then
		cp -a ${ROOT}sbin/init.system ${ROOT}sbin/init
	fi
}
