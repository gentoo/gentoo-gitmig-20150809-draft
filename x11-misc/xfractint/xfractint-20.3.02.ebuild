# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.3.02.ebuild,v 1.5 2004/07/20 14:46:40 spock Exp $

inherit eutils flag-o-matic

MY_P=xfractint-20.03p02
S="${WORKDIR}/${MY_P}"
DESCRIPTION="The best fractal generator for X."
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://www.fractint.org/ftp/current/linux/${P/int-/}.tar.gz"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT="0"
LICENSE="freedist"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-20.03p01-make.patch
}

src_compile() {
	cd ${S}
	cp Makefile Makefile.orig
	replace-flags "-funroll-all-loops" "-funroll-loops"
	sed -e "s:CFLAGS = :CFLAGS = $CFLAGS :" Makefile.orig >Makefile

	emake -j1
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/xfractint
	dodir /usr/man/man1

	make \
		BINDIR=${D}usr/bin \
		MANDIR=${D}usr/man/man1 \
		SRCDIR=${D}usr/share/xfractint \
		install || die

	insinto /etc/env.d
	newins ${FILESDIR}/xfractint.envd 60xfractint
}

pkg_postinst() {
	einfo
	einfo "XFractInt requires the FRACTDIR variable to be set in order to start."
	einfo "Please re-login or \`source /etc/profile\` to have this variable set automatically."
	einfo
}
