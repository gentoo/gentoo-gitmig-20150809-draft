# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/slidentd/slidentd-1.0.0.ebuild,v 1.5 2004/08/31 08:38:47 dragonheart Exp $

DESCRIPTION="A secure, lightweight ident daemon."
SRC_URI="http://www.uncarved.com/slidentd/${P}.tar.gz"
HOMEPAGE="http://www.uncarved.com/slidentd/"
KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND="dev-libs/dietlibc
	dev-libs/libowfat
	>=sys-apps/sed-4"

RDEPEND="virtual/inetd"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:^\tCFLAGS=\$(diet_cflag.*:\tCFLAGS=${CFLAGS} \${diet_cflags}:" \
		-e "s:^\tCC\:=diet -Os \$(CC):\tCC\:=diet -Os gcc:" \
		Makefile
}

src_compile() {
	make build_mode=diet INCLUDES=-I/usr/include/libowfat LIBDIRS=-L/usr/lib || die
}

src_install () {
	make DESTDIR=${D} install || die

	exeinto /var/lib/supervise/slidentd
	newexe ${FILESDIR}/slidentd-run run
}

pkg_postinst() {
	einfo "You need to start your supervise service:"
	einfo '# ln -s /var/lib/supervise/slidentd/ /service'
	einfo
}
