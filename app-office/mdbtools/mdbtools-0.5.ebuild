# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mdbtools/mdbtools-0.5.ebuild,v 1.9 2004/01/17 02:20:33 darkspecter Exp $

DESCRIPTION="A set of libraries and utilities for reading Microsoft Access database (MDB) files"
HOMEPAGE="http://sourceforge.net/projects/mdbtools/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="odbc X"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 hppa"

DEPEND=">=dev-libs/glib-2
	sys-libs/ncurses
	sys-libs/readline
	>=sys-devel/flex-2.5.0
	>=sys-devel/bison-1.35
	X? ( >=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		>=gnome-base/libgnomeui-2 )
	odbc? ( >=dev-db/unixODBC-2.0 )"

src_compile() {
	local myconf
	use odbc && myconf="${myconf} --with-unixodbc=/usr"

	econf --enable-sql \
		${myconf} || die "configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING* NEWS README* TODO AUTHORS HACKING ChangeLog

	# add a compat symlink
	dosym /usr/bin/gmdb2 /usr/bin/gmdb
}
