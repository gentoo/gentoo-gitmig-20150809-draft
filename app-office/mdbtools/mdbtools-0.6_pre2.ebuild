# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mdbtools/mdbtools-0.6_pre2.ebuild,v 1.2 2009/12/17 10:55:07 ssuominen Exp $

WANT_AUTOMAKE="1.7"

inherit eutils autotools

MY_P=${P/_/}
S="${WORKDIR}/${PN}-cvs-20050624"

DESCRIPTION="A set of libraries and utilities for reading Microsoft Access database (MDB) files"
HOMEPAGE="http://sourceforge.net/projects/mdbtools"
SRC_URI="mirror://gentoo/${PN}-cvs-20050624.tar.gz"

IUSE="gnome odbc"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND=">=dev-libs/glib-2
	sys-libs/ncurses
	sys-libs/readline
	gnome? (
		>=gnome-base/libglade-2
		>=gnome-base/libgnomeui-2 )
	odbc? ( >=dev-db/unixODBC-2.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/flex-2.5.0
	>=sys-devel/bison-1.35"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc34.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

	# This is necessary since the upstream tarball was created with a
	# buggy libtool, and the .so suffix in library names is lost in
	# some platforms (e.g. amd64).  Starting with libtool 2.2.4 it is
	# also necessary to remove the acinclude.m4 file since it contains
	# an old libtool.m4 that is obsolete, #227257.
	rm "${S}"/acinclude.m4
	eautoreconf
}

src_compile() {
	local myconf
	use odbc && myconf="${myconf} --with-unixodbc=/usr"

	econf --enable-sql \
		${myconf} || die "configure failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc COPYING* NEWS README* TODO AUTHORS HACKING ChangeLog

	# add a compat symlink (gmdb2 is not compiled if gnome USE flag is disabled)
	use gnome && dosym gmdb2 /usr/bin/gmdb
}
