# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/evkeyd/evkeyd-0.1_pre3.ebuild,v 1.1 2003/06/20 20:45:26 vladimir Exp $

DESCRIPTION="Input event layer media key activator"
HOMEPAGE="http://www.stampflee.com/evkeyd/"
MY_PV=${PV/_/}
SRC_URI="http://www.stampflee.com/evkeyd/downloads/evkeyd-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""
DEPEND=""
S=${WORKDIR}/${PN}-${MY_PV}

# Some opto breaks forking - upstream bug
#CFLAGS=""

src_compile() {
	emake || die
}

src_install() {
	dosbin evkeyd
	exeinto /etc/init.d
	newexe ${FILESDIR}/evkeyd.rc evkeyd
}
