# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/slidentd/slidentd-1.0.0.ebuild,v 1.11 2008/01/25 20:28:30 bangert Exp $

DESCRIPTION="A secure, lightweight ident daemon"
HOMEPAGE="http://www.uncarved.com/static/slidentd/"
SRC_URI="http://www.uncarved.com/static/slidentd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND="dev-libs/libowfat"
RDEPEND="${DEPEND}
	virtual/inetd"

src_unpack() {
#		-e "/^normal_cflags/s:=.*:=-DNDEBUG ${CFLAGS} -I/usr/include/libowfat:" \
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^diet_cflags/s:=.*:=-DNDEBUG ${CFLAGS} -I/usr/include/libowfat -static:" \
		-e '/ALL=/s:stripobjects::' \
		-e '/ALL=/s:strip::' \
		Makefile || die
}

src_compile() {
	emake -j1 build_mode=diet || die
}

src_install () {
	emake DESTDIR="${D}" install || die

	exeinto /var/lib/supervise/slidentd
	newexe "${FILESDIR}"/slidentd-run run
}

pkg_postinst() {
	elog "You need to start your supervise service:"
	elog '# ln -s /var/lib/supervise/slidentd /service/'
}
