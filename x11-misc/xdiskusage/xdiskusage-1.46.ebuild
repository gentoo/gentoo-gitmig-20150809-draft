# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.46.ebuild,v 1.1 2003/10/29 12:49:51 brandy Exp $

DESCRIPTION="xdiskusage is a front end to xdu for viewing disk usage graphically under X11"
SRC_URI="http://xdiskusage.sourceforge.net/${P}.tgz"
HOMEPAGE="http://xdiskusage.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	x11-libs/fltk"


src_compile() {

	econf || die "configure failed"

	make CXXFLAGS="$CXXFLAGS `fltk-config --cxxflags`" LDLIBS="`fltk-config --ldflags`" \
		|| die "parallel make failed"

}

src_install () {

	dobin xdiskusage
	doman xdiskusage.1
	dodoc README

}
