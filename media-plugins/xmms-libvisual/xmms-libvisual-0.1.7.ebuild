# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-libvisual/xmms-libvisual-0.1.7.ebuild,v 1.3 2005/02/03 00:03:54 vapier Exp $

inherit eutils

MY_PN="libvisual-xmms"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="an abstraction library for applications to create audio visualisation plugins"
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="media-sound/xmms
	 media-libs/libsdl
	 virtual/opengl
	 media-libs/libvisual"

src_install() {
	make install DESTDIR="${D}" || die

	if [ "$(get_libdir)" != "lib" ]; then
		mv ${D}/usr/lib ${D}/usr/$(get_libdir)
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
}
