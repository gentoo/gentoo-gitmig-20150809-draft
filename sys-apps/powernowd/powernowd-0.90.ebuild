# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powernowd/powernowd-0.90.ebuild,v 1.2 2004/04/06 23:27:45 mr_bones_ Exp $

EV=hun6
DESCRIPTION="Daemon to control the speed and voltage of CPUs"
HOMEPAGE="http://www.deater.net/john/powernowd.html http://n-dimensional.de/projects/cpufreq/"
SRC_URI="http://n-dimensional.de/projects/cpufreq/${P}${EV}.tar.gz"
#http://www.deater.net/john/${P}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${P}${EV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin powernowd || die
	doman debian/powernowd.1
	dodoc README

	insinto /etc/conf.d
	newins ${FILESDIR}/powernowd.confd powernowd
	exeinto /etc/init.d
	newexe ${FILESDIR}/powernowd.rc powernowd
}
