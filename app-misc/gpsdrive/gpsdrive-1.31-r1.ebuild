# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-1.31-r1.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="displays GPS position on a map"
HOMEPAGE="http://gpsdrive.kraftvoll.at"
SRC_URI="http://gpsdrive.kraftvoll.at/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="mysql nls"
DEPEND="sys-devel/gettext
	>=media-libs/gdk-pixbuf-0.21.0
	mysql? ( >=dev-db/mysql-3.23.54a )"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv configure configure.orig
	sed -e "s:^CFLAGS=\"-O2 -Wall\":CFLAGS=${CFLAGS}:" \
	    -e "s:^CXXFLAGS=\"\$CFLAGS\":CXXFLAGS=${CXXFLAGS}:" \
	    configure.orig > configure
	chmod +x configure
}

src_compile() {
	local myconf
	use mysql || myconf="${myconf} --disable-mysql"
	econf ${myconf} `use_enable nls` || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die
}
