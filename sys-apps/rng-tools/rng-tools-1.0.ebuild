# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-1.0.ebuild,v 1.3 2004/04/07 22:11:36 lv Exp $

DESCRIPTION="Daemon to use hardware random number generators."
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	doman rngd.8
	dodoc AUTHORS ChangeLog
	exeinto /etc/init.d
	doexe ${FILESDIR}/rngd
}
