# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16menuedit/e16menuedit-0.1.ebuild,v 1.9 2005/03/29 14:44:06 luckyduck Exp $

DESCRIPTION="Menu editor for enlightenment DR16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86 ppc sparc"

DEPEND="virtual/x11
	>=x11-wm/enlightenment-0.16
	=x11-libs/gtk+-1*
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-lgdbm -lgdk_imlib::' Makefile
	sed -i '/gdk_imlib/s:.*::' viewer.c
}

src_compile() {
	emake DEVFLAGS="${CFLAGS}" || die
}

src_install() {
	 dobin e16menuedit || die
	 dodoc README
}
