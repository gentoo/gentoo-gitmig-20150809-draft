# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linux-atm/linux-atm-2.4.1.ebuild,v 1.5 2004/04/27 02:05:11 vapier Exp $

inherit eutils

DESCRIPTION="Tools for ATM"
HOMEPAGE="http://linux-atm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips hppa ~amd64 ia64"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_compile() {
	econf || die
	sed -i 's:hosts.atm :hosts.atm ${D}:' src/config/Makefile
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		man_prefix=/usr/share/man \
		install || die

	dodoc README NEWS THANKS AUTHORS BUGS INSTALL ChangeLog
	dodoc doc/README* doc/atm*
}
