# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linux-atm/linux-atm-2.4.1-r1.ebuild,v 1.8 2005/07/21 19:51:37 mrness Exp $

inherit eutils

DESCRIPTION="Tools for ATM"
HOMEPAGE="http://linux-atm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""
RESTRICT="autoconfig"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix labels at end of compound statement errors
	epatch ${FILESDIR}/${PV}-gcc34.patch

	# Fedora patch to fix gcc-4 compilation issues
	# In particular, this corrects "invalid lvalue in assignment" errors
	epatch ${FILESDIR}/${PV}-gcc4.patch

	# Fedora patch: include stdlib.h for strtol prototype in sigd/cfg_y.y
	epatch ${FILESDIR}/${PV}-stdlib.patch

	# Fixed broken compilation on uclibc env (bug #61184)
	epatch ${FILESDIR}/${PV}-uclibc.patch
}

src_compile() {
	econf || die "configure failed"
	sed -i 's:cp hosts.atm /etc:cp hosts.atm ${D}/etc:' src/config/Makefile || die "sed operation on Makefile failed"
	emake || die "make failed"
}

src_install() {
	make \
		DESTDIR=${D} \
		man_prefix=/usr/share/man \
		install || die "make install failed"

	dodoc README NEWS THANKS AUTHORS BUGS INSTALL ChangeLog
	dodoc doc/README* doc/atm*
}
