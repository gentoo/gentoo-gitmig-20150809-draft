# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-0.71.ebuild,v 1.1 2003/11/18 00:24:27 genone Exp $


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
	use kde \
		 && myconf="${myconf} --with-kde-includes=${KDEDIR}/include" \
		|| myconf="${myconf} --without-kde-includes"
	use postgres \
		&& myconf="${myconf} --with-postgresql-includes=/usr/include/postgresql" \
		|| myconf="${myconf} --without-postgresql-includes"
	use mysql \
		&& myconf="${myconf} --with-postgresql-includes=/usr/include/mysql" \
		|| myconf="${myconf} --without-postgresql-includes"

	econf ${myconf} || die
	emake || die
}

src_install() {
	export PATH="${PATH}:${D}/usr/bin"
	einstall || die
}

