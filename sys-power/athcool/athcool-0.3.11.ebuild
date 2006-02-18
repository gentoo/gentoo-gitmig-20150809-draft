# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/athcool/athcool-0.3.11.ebuild,v 1.2 2006/02/18 06:43:01 vapier Exp $

DESCRIPTION="small utility to toggle Powersaving mode for AMD Athlon/Duron processors"
HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool"
SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="sys-apps/pciutils"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall || die
	doinitd "${FILESDIR}"/athcool
	dodoc README ChangeLog
}

pkg_postinst() {
	ewarn "WARNING: Depending on your motherboard and/or hardware components, enabling powersaving mode may cause:"
	ewarn " * noisy or distorted sound playback"
	ewarn " * a slowdown in harddisk performance"
	ewarn " * system locks or instability"
	ewarn "If you met those problems, you should not use athcool. Please use athcool AT YOUR OWN RISK!"
}
