# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-0.72.ebuild,v 1.1 2003/12/02 07:13:39 genone Exp $


DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde postgres mysql sdl"
DEPEND=">=x11-base/xfree-4.3.0
	>=x11-libs/qt-3.1
	kde? ( >=kde-base/kdelibs-3.1 )
	sdl? ( media-libs/libsdl )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:@ln.*::" Makefile*
	sed -i "s:@rm -f /usr/.*::" Makefile*
	epatch ${FILESDIR}/non-symlink-${PV}.patch
}

src_compile() {
	local myconf

	myconf="${myconf} `use_with kde kde-includes ${KDEDIR}/include`"
	myconf="${myconf} `use_with mysql mysql-includes /usr/include/mysql`"
	myconf="${myconf} `use_with postgres postgresql-includes /usr/include/postgresql/server`"
	myconf="${myconf} `use_with sdl sdl-includes /usr/include/SDL`"

	econf ${myconf} || die

	use kde || sed -i "s:#define HAVE_KDE_COMPONENT 1:#undef HAVE_KDE_COMPONENT:" config.h
	use mysql || sed -i "s:#define HAVE_MYSQL_COMPONENT 1:#undef HAVE_MYSQL_COMPONENT:" config.h
	use postgres || sed -i "s:#define HAVE_PGSQL_COMPONENT 1:#undef HAVE_PGSQL_COMPONENT:" config.h
	use sdl || sed -i "s:#define HAVE_SDL_COMPONENT 1:#undef HAVE_SDL_COMPONENT:" config.h

	emake || die
}

src_install() {
	export PATH="${PATH}:${D}/usr/bin"
	einstall || die
}

