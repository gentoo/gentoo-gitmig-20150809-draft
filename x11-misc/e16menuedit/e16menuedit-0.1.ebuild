# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16menuedit/e16menuedit-0.1.ebuild,v 1.4 2004/02/29 21:33:04 vapier Exp $

DESCRIPTION="Menu editor for enlightenment DR16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/x11
	>=x11-wm/enlightenment-0.16
	=x11-libs/gtk+-1*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-lgdbm -lgdk_imlib::' Makefile
}

src_compile() {
	emake DEVFLAGS="${CFLAGS}" || die
}

src_install() {
	 dobin e16menuedit || die
	 dodoc README
}
