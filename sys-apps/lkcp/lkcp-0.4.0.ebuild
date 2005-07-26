# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lkcp/lkcp-0.4.0.ebuild,v 1.1 2005/07/26 23:01:14 r3pek Exp $ 

DESCRIPTION="Live Kernel Configuration Panel is an ncurses interface to the run-time Linux kernel configuration data (/proc)"
HOMEPAGE="http://freshmeat.net/projects/lkcp"
SRC_URI="https://webspace.utexas.edu/~hyoussef/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	cd ${S}/src
	sed -i -e "/^LKCPDIR/s:\/usr\/local\/bin:\$(DESTDIR)\/usr\/bin:" Makefile
	emake || die "emake failed"
}

src_install() {
	cd ${S}/src
	dodir /usr/bin
	make install DESTDIR="${D}" || die "einstall failed"
}
