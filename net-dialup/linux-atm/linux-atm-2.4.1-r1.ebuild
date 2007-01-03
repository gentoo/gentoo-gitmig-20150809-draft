# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linux-atm/linux-atm-2.4.1-r1.ebuild,v 1.15 2007/01/03 16:58:14 vapier Exp $

inherit eutils libtool

DESCRIPTION="Tools for ATM"
HOMEPAGE="http://linux-atm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RESTRICT="test"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Fix labels at end of compound statement errors
	epatch "${FILESDIR}"/${PV}-gcc34.patch

	# Fedora patch to fix gcc-4 compilation issues
	# In particular, this corrects "invalid lvalue in assignment" errors
	epatch "${FILESDIR}"/${PV}-gcc4.patch

	# Fedora patch: include stdlib.h for strtol prototype in sigd/cfg_y.y
	epatch "${FILESDIR}"/${PV}-stdlib.patch

	sed -i '/#define _LINUX_NETDEVICE_H/d' src/arpd/*.c || die
	sed -i 's:cp hosts.atm /etc:cp hosts.atm ${DESTDIR}/etc:' src/config/Makefile.in || die "sed operation on Makefile failed"

	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc README NEWS THANKS AUTHORS BUGS ChangeLog
	dodoc doc/README* doc/atm*
}
