# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeda/libgeda-20050313.ebuild,v 1.1 2005/03/26 00:32:45 plasmaroo Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgeda - this library provides functions needed for a working gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz"

IUSE="png static"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=dev-libs/glib-2.4.8
	>=x11-libs/gtk+-2.2
	virtual/x11

	>=dev-util/guile-1.6.3
	>=dev-util/pkgconfig-0.15.0
	png? ( >=sci-libs/libgdgeda-2.0.15 )"

src_compile () {
	local myconf

	use png || myconf='--disable-gdgeda'
	use static && myconf="${myconf} --enable-static --disable-shared"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README
}
