# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/viewer/viewer-0.7.3.ebuild,v 1.1 2003/10/20 09:50:15 brandy Exp $

DESCRIPTION="A stero pair image viewer (supports ppm's only)"
HOMEPAGE="http://www-users.cs.umn.edu/~wburdick/geowall/viewer.html"
SRC_URI=ftp://ftp.cs.umn.edu/dept/users/wburdick/geowall/${P}.tar.gz

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/opengl"

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin viewer
	doman viewer.1

	dodoc AUTHORS ChangeLog COPYING README
}

