# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-1.1.ebuild,v 1.10 2006/03/19 22:23:23 vapier Exp $

DESCRIPTION="Daemon to use hardware random number generators"
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	# we want this extra tool
	cd "${S}"
	echo 'bin_PROGRAMS = randstat' > contrib/Makefile.am
	aclocal && automake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog
	doinitd "${FILESDIR}"/rngd
}
