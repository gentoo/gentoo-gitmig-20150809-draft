# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.8.ebuild,v 1.5 2004/03/30 12:17:46 aliz Exp $

MY_P=${PN}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hypertext info and man viewer based on (n)curses"
SRC_URI="http://dione.ids.pl/~pborys/software/pinfo/pinfo-${PV}.tar.gz"
HOMEPAGE="http://dione.ids.pl/~pborys/pinfo"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ia64 ~amd64"
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
