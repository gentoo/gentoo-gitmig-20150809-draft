# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.6.1.ebuild,v 1.3 2004/06/14 08:39:22 kloeri Exp $

inherit eutils

DESCRIPTION="PBButtons is a program to map special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="~ppc"
IUSE=""
DEPEND="virtual/glibc
	>=sys-apps/baselayout-1.8.6.12-r1"
RDEPEND=""
SLOT=0
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-compat.patch
}

src_compile() {
	econf || die "sorry, failed to configure pbbuttonsd"
	make || die "sorry, failed to compile pbbuttonsd"
}

src_install() {
	dodir /etc/power
	make DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README COPYING
}

pkg_postinst(){
	einfo "This version of pbbuttonsd can replace PMUD functionality."
	einfo "If you want PMUD installed and running, you should set"
	einfo "replace_pmud=no in /etc/pbbuttonsd.conf. Otherwise you can"
	einfo "try setting replace_pmud=yes in /etc/pbbuttonsd.conf and"
	einfo "disabling PMUD"
}
