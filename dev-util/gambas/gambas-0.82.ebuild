# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-0.82.ebuild,v 1.1 2004/02/05 04:09:02 genone Exp $


DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde postgres mysql sdl"
DEPEND=">=sys-devel/automake-1.7.5
	>=sys-devel/autoconf-2.57
	>=x11-base/xfree-4.3.0
	>=x11-libs/qt-3.1
	kde? ( >=kde-base/kdelibs-3.1 )
	sdl? ( media-libs/libsdl )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm Makefile*
	cp "${FILESDIR}/Makefile.am-${PV}" ./Makefile.am
	automake
	autoconf
	epatch ${FILESDIR}/non-symlink-${PV}.patch
}

src_compile() {
	local myconf

	myconf="${myconf} `use_with kde kde-includes ${KDEDIR}/include`"
	myconf="${myconf} `use_with mysql mysql-includes /usr/include/mysql`"
	myconf="${myconf} `use_with postgres postgresql-includes /usr/include/postgresql/server`"
	myconf="${myconf} `use_with sdl sdl-includes /usr/include/SDL`"

	econf ${myconf} --enable-optimization || die

	use kde || sed -i "s:#define HAVE_KDE_COMPONENT 1:#undef HAVE_KDE_COMPONENT:" config.h
	use mysql || sed -i "s:#define HAVE_MYSQL_COMPONENT 1:#undef HAVE_MYSQL_COMPONENT:" config.h
	use postgres || sed -i "s:#define HAVE_PGSQL_COMPONENT 1:#undef HAVE_PGSQL_COMPONENT:" config.h
	use sdl || sed -i "s:#define HAVE_SDL_COMPONENT 1:#undef HAVE_SDL_COMPONENT:" config.h

	emake || die
}

src_install() {
	export PATH="${D}/usr/bin:${PATH}"
	einstall || die

	dodoc README INSTALL AUTHORS ChangeLog COPYING TODO

	# only install the API docs and examples with USE=doc
	if use doc; then
		mv ${D}/usr/share/help ${D}/usr/share/doc/${PF}/html
		mv ${D}/usr/share/examples ${D}/usr/share/doc/${PF}/examples
		einfo "Compiling examples ..."
		cd ${D}/usr/share/doc/${PF}/examples
		for p in *; do
			cd $p
			gbc -ag
			gba
			cd ..
		done
	fi
	rm -rf ${D}/usr/share/help ${D}/usr/share/examples
}
