# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/trswm/trswm-0.3.ebuild,v 1.3 2003/12/31 04:26:11 obz Exp $

DESCRIPTION="A window manager"
HOMEPAGE="http://www.relex.ru/~yarick/trswm/"
SRC_URI="http://www.relex.ru/~yarick/trswm/${P}.tar.gz
	http://www.relex.ru/~yarick/trswm/trswm-config.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="=dev-lang/lua-4.0*"

src_compile() {
	mv Options Options.orig
	sed -e "s/\(CFLAGS=\)/\1${CFLAGS} /" Options.orig > Options
	emake || die
}

src_install() {
	exeinto /usr/X11R6/bin
	doexe trswm
	insinto /etc/X11/trswm
	doins ../trswm-devel/*
	dodoc BUGS Roadmap
}
