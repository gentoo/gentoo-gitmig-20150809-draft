# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeda/libgeda-20040111.ebuild,v 1.2 2005/02/17 23:26:37 hansmi Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgeda - this library provides functions needed for a working gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz"

IUSE="png static"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-2.2
	virtual/x11

	>=dev-util/guile-1.4.1
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
	dodoc AUTHORS CONTRIBUTORS COPYING ChangeLog NEWS README
}
