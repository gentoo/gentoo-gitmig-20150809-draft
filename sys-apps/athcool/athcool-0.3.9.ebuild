# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/athcool/athcool-0.3.9.ebuild,v 1.1 2005/02/06 23:16:24 vapier Exp $

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
	doinitd ${FILESDIR}/athcool
	dodoc README ChangeLog
}

pkg_postinst() {
	ewarn "WARNING:  This program can cause instability in your system."
	ewarn "Use at your own risk!"
}
