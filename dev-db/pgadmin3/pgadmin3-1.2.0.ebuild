# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.2.0.ebuild,v 1.1 2005/03/25 20:15:44 nakano Exp $

inherit eutils libtool wxwidgets

IUSE="unicode gtk2 postgres"

RESTRICT="nomirror"
DESCRIPTION="wxWindows GUI for PostgreSQL"
HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/pgadmin3/release/v1.2.0/src/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

# Need 2.4.1-r1 for the extras in contrib
DEPEND=">=x11-libs/wxGTK-2.5.3
	|| ( >=dev-db/postgresql-7.3.5 >=dev-db/postgresql-7.4.1-r2 )
	>=sys-apps/sed-4
	>=x11-libs/gtk+-2.4.9"

pkg_setup() {
	if use unicode && use gtk2; then
		einfo "in USE \"gtk2 unicode\""
	else	die "You must put \"gtk2 unicode\" in your USE."
	fi
}

src_compile() {
	export WX_GTK_VER=2.5
	export WX_HOME=/usr

	local myconf

	if use unicode ; then
		need-wxwidgets unicode || die "You need to emerge wxGTK with unicode in your USE"
	elif ! use gtk2 ; then
		need-wxwidgets gtk || die "You need to emerge wxGTK with gtk in your USE"
	else
		need-wxwidgets gtk2 || die "You need to emerge wxGTK with gtk2 in your USE"
	fi

	myconf="${myconf} --with-pgsql-include=/usr/include/postgresql"
	myconf="${myconf} --with-wx-config=/lib/wx/config/${WX_CONFIG_NAME}"
	myconf="${myconf} --enable-gtk2"
	myconf="${myconf} --enable-unicode"
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
