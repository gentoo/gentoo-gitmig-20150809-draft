# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/athcool/athcool-0.3.0.ebuild,v 1.1 2003/08/09 21:56:13 lisa Exp $


DESCRIPTION="athcool is a small utility, enabling/disabling Powersaving mode for AMD Athlon/Duron processors."
HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool"
SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"

DEPEND="sys-apps/pciutils"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install() {
	einstall || die
	exeinto /etc/init.d
	newexe "${FILESDIR}/init" init
}
