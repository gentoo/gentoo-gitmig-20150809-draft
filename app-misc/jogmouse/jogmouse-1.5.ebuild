# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/jogmouse/jogmouse-1.5.ebuild,v 1.1 2001/12/10 17:39:49 jerrya Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to use VAIO JogDial as a scrollwheel under X."
SRC_URI="http://nerv-un.net/~dragorn/jogmouse/${P}.tar.gz"

HOMEPAGE="http://nerv-un.net/~dragorn/jogmouse/"

DEPEND="virtual/glibc
	virtual/x11"


src_compile() {
	emake || die
}

src_install () {
	dobin jogmouse

	dodoc README
}
