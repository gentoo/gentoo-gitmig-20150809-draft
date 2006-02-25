# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-5.0.2.ebuild,v 1.10 2006/02/25 01:31:44 ka0ttic Exp $

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.wanadoo.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 mips hppa"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	yes "" | make config
	use nls || sed -i 's/\(ENABLE_NLS\ =\ \)y/\1n/g' build/CONFIG
	make PREFIX=/usr || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man{1,8}
	dodir /var/log/sa
	keepdir /var/log/sa

	make \
		DESTDIR=${D} \
		PREFIX=/usr \
		MAN_DIR=/usr/share/man \
		DOC_DIR=/usr/share/doc/${PF} \
		install || die
}
