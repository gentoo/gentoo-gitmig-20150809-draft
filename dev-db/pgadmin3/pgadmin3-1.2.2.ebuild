# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.2.2.ebuild,v 1.9 2007/07/02 14:31:03 peper Exp $

inherit eutils libtool wxwidgets

IUSE=""

RESTRICT="mirror"
DESCRIPTION="wxWindows GUI for PostgreSQL"
HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/pgadmin3/release/v${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="=x11-libs/wxGTK-2.6*
	dev-db/libpq
	>=sys-apps/sed-4"

pkg_setup() {
	if ! built_with_use '=x11-libs/wxGTK-2.6*' unicode ; then
		die "${PN} requires =x11-libs/wxGTK-2.6* emerged with USE='unicode'"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S} || die "Couldn't cd to ${S}"
	epatch ${FILESDIR}/${P}-configure.patch
}

src_compile() {
	export WX_GTK_VER="2.6"
	export WX_HOME="/usr"
	need-wxwidgets unicode

	local myconf
	myconf="${myconf} --enable-unicode"
	myconf="${myconf} --enable-gtk2"
	myconf="${myconf} --with-pgsql-include=/usr/include/postgresql"
	myconf="${myconf} --with-wx-config=${WX_CONFIG/\/usr}"
	myconf="${myconf} --enable-postgres"
	LDFLAGS=-L/usr/lib/postgresql econf ${myconf} || die

	cd ${S}
	emake || die
}

src_install() {
	einstall || die

	dodir /usr/share/pixmaps

	cp ${S}/src/include/images/elephant48.xpm ${D}/usr/share/pixmaps/pgadmin3.xpm

	dodir /usr/share/pgadmin3

	cp ${S}/src/include/images/elephant48.xpm ${D}/usr/share/pgadmin3/pgadmin3.xpm

	chmod 644 ${D}/usr/share/pixmaps/pgadmin3.xpm
	chmod 644 ${D}/usr/share/pgadmin3/pgadmin3.xpm

	dodir /usr/share/applications

	cp ${S}/pkg/pgadmin3.desktop ${D}/usr/share/applications/pgadmin3.desktop
	chmod 644 ${D}/usr/share/applications/pgadmin3.desktop

	dodir /usr/share/applnk/Development

	cp ${S}/pkg/pgadmin3.desktop ${D}/usr/share/applnk/Development/pgadmin3.desktop
	chmod 644 ${D}/usr/share/applnk/Development/pgadmin3.desktop
}
