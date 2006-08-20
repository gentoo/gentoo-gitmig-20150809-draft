# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-2.ebuild,v 1.5 2006/08/20 09:13:30 blubb Exp $

DESCRIPTION="Daemon to use hardware random number generators."
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc x86"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# we want this extra tool
	cd ${S}
	echo 'bin_PROGRAMS = randstat' >contrib/Makefile.am
	aclocal
	automake
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog
	exeinto /etc/init.d
	doexe ${FILESDIR}/2/rngd
	insinto /etc/conf.d
	newins ${FILESDIR}/2/rngd-conf rngd
}
