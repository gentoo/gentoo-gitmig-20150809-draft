# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-1.1.ebuild,v 1.2 2004/04/09 14:59:25 dholm Exp $

DESCRIPTION="Daemon to use hardware random number generators."
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/glibc"

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
	doexe ${FILESDIR}/rngd
}
