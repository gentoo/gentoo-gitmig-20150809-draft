# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linux-atm/linux-atm-2.4.1-r1.ebuild,v 1.5 2005/04/09 12:34:01 corsair Exp $

inherit eutils

DESCRIPTION="Tools for ATM"
HOMEPAGE="http://linux-atm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 ~sparc x86"
IUSE=""
RESTRICT="autoconfig"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch ${FILESDIR}/${PV}-uclibc.patch
}

src_compile() {
	econf || die "configure failed"
	sed -i 's:hosts.atm :hosts.atm ${D}:' src/config/Makefile || die "fail seding the Makefile"
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
