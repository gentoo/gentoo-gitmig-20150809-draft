# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.6.6.ebuild,v 1.8 2007/01/23 16:19:30 genone Exp $

inherit eutils

DESCRIPTION="program to map special Powerbook/iBook keys"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE="debug"

DEPEND="virtual/libc
	>=sys-apps/baselayout-1.8.6.12-r1"
RDEPEND=""
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-laptopmode-noatime.patch
}

src_compile() {
	econf $(use_enable debug) || die "sorry, failed to configure pbbuttonsd"
	emake || die "sorry, failed to compile pbbuttonsd"
}

src_install() {
	dodir /etc/power
	make DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README
}

pkg_postinst() {
	ewarn "If you need extra security, you can tell pbbuttonsd to only accept"
	ewarn "input from one user.  You can set the userallowed option in"
	ewarn "/etc/pbbuttonsd.conf to limit access."
	elog
	elog "This version of pbbuttonsd can replace PMUD functionality."
	elog "If you want PMUD installed and running, you should set"
	elog "replace_pmud=no in /etc/pbbuttonsd.conf. Otherwise you can"
	elog "try setting replace_pmud=yes in /etc/pbbuttonsd.conf and"
	elog "disabling PMUD"
}
