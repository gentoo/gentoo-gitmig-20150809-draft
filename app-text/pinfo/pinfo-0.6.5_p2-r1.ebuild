# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.5_p2-r1.ebuild,v 1.12 2004/03/12 09:18:44 mr_bones_ Exp $

MY_P=${PN}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hypertext info and man viewer based on (n)curses"
SRC_URI="http://zeus.polsl.gliwice.pl/~pborys/stable-version/${MY_P}.tar.gz"
HOMEPAGE="http://zeus.polsl.gliwice.pl/~pborys/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls readline"

DEPEND="sys-libs/ncurses
	sys-devel/bison
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} sysconfdir=/etc install || die
}
