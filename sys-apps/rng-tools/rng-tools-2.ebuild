# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-2.ebuild,v 1.7 2007/04/21 20:52:56 nelchael Exp $

DESCRIPTION="Daemon to use hardware random number generators."
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""
DEPEND=""

src_unpack() {

	unpack ${A}

	# we want this extra tool
	cd ${S}
	echo 'bin_PROGRAMS = randstat' > contrib/Makefile.am
	aclocal
	automake

}

src_install() {

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog
	doinitd ${FILESDIR}/2/rngd
	newconfd ${FILESDIR}/2/rngd-conf rngd

}
