# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-5.0.0.ebuild,v 1.3 2004/02/02 02:48:05 avenj Exp $

DESCRIPTION="System performance tools for Linux"
SRC_URI="http://perso.wanadoo.fr/sebastien.godard/${P}.tar.gz"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE="nls"

DEPEND="virtual/glibc"
RDEPEND="nls? ( sys-devel/gettext )"

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
