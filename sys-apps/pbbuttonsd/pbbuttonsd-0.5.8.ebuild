# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pbbuttonsd/pbbuttonsd-0.5.8.ebuild,v 1.2 2004/02/10 05:20:27 vapier Exp $

DESCRIPTION="program to map special Powerbook/iBook keys in Linux"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc"

DEPEND="virtual/glibc
	>=sys-apps/baselayout-1.8.6.12-r1"
RDEPEND=""

src_compile() {
	econf || die
	make || die "compile failed"
}

src_install() {
	local mydir=/var/lib
	dodir /etc/power
	make \
		sysconfdir=${D}/etc \
		localstatedir=${D}/${mydir} \
		DESTDIR=${D} \
		install \
		|| die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README COPYING
	#fix the symlink
	rm ${D}/etc/pbbuttonsd.conf
#	mv ${D}/var/lib/pbbuttons/pbbuttonsd.conf ${D}/etc/pbbuttonsd.conf
#	dosym /etc/pbbuttonsd.conf /var/lib/pbbuttons/pbbuttonsd.conf
	dosym ${mydir}/pbbuttons/pbbuttonsd.conf /etc/pbbuttonsd.conf
	dodir /etc/env.d
	echo "CONFIG_PROTECT=${mydir}/pbbuttonsd" > ${D}/etc/env.d/10pbbuttonsd
}

pkg_postinst(){
	einfo "This version of pbbuttonsd can replace PMUD functionality."
	einfo "If you want PMUD installed and running, you should set"
	einfo "replace_pmud=no in /etc/pbbuttonsd.conf. Otherwise you can"
	einfo "try setting replace_pmud=yes in /etc/pbbuttonsd.conf and"
	einfo "disabling PMUD"
}
