# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.8.ebuild,v 1.1 2003/11/25 23:06:28 mr_bones_ Exp $

DESCRIPTION="An image viewer that uses OpenGL"
HOMEPAGE="http://gliv.tuxfamily.org"
SRC_URI="http://gliv.tuxfamily.org/gliv-${PV}.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.2
	>=x11-libs/gtkglext-1.0.2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		`use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall                 || die
	dodoc README NEWS THANKS || die "dodoc failed"
}
