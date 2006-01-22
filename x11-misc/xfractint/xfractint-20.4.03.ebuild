# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.4.03.ebuild,v 1.1 2006/01/22 15:46:55 spock Exp $

inherit eutils flag-o-matic

MY_P=xfractint-20.04p03
S="${WORKDIR}/${MY_P}"
DESCRIPTION="The best fractal generator for X."
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://www.fractint.org/ftp/current/linux/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="freedist"
IUSE=""

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	|| ( x11-libs/libX11 virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

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

	chmod 0644 -R ${D}usr/share/xfractint/*

	insinto /etc/env.d
	newins ${FILESDIR}/xfractint.envd 60xfractint
}

pkg_postinst() {
	einfo
	einfo "XFractInt requires the FRACTDIR variable to be set in order to start."
	einfo "Please re-login or \`source /etc/profile\` to have this variable set automatically."
	einfo
}
