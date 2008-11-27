# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/athcool/athcool-0.3.11-r1.ebuild,v 1.2 2008/11/27 19:31:11 vapier Exp $

inherit eutils

DESCRIPTION="small utility to toggle Powersaving mode for AMD Athlon/Duron processors"
HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool"
SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	emake install DESTDIR="${D}" || die
	doinitd "${FILESDIR}"/athcool
	dodoc README ChangeLog
}

pkg_postinst() {
	ewarn "WARNING: Depending on your motherboard and/or hardware components,"
	ewarn "enabling powersaving mode may cause:"
	ewarn " * noisy or distorted sound playback"
	ewarn " * a slowdown in harddisk performance"
	ewarn " * system locks or instability"
	ewarn " * file system corruption"
	ewarn "If you met those problems, you should not use athcool.  Please use"
	ewarn "athcool AT YOUR OWN RISK!"
}
