# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.5_p2-r1.ebuild,v 1.3 2002/08/07 14:43:08 cselkirk Exp $

MY_P=${PN}-0.6.5p2
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hypertext info and man viewer based on (n)curses"
SRC_URI="http://zeus.polsl.gliwice.pl/~pborys/stable-version/${MY_P}.tar.gz"
HOMEPAGE="http://zeus.polsl.gliwice.pl/~pborys/"
KEYWORDS="x86 ppc"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	nls? ( >=sys-devel/gettext-0.10.39 )
	>=sys-devel/bison-1.28"
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	nls? ( >=sys-devel/gettext-0.10.39 )"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	local myc

	use readline && myc="${myc} --with-readline" || myc="${myc} --without-readline"
	use nls && myc="${myc} --enable-nls" || myc="${myc} --disable-nls"

	econf ${myc} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} sysconfdir=/etc install || die
}
