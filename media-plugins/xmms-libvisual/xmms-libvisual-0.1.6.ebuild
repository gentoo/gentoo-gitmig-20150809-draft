# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-libvisual/xmms-libvisual-0.1.6.ebuild,v 1.2 2004/10/02 17:58:03 eradicator Exp $

IUSE=""

inherit eutils

MY_PN="libvisual-xmms"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${MY_P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND="media-sound/xmms
	 media-libs/libsdl
	 virtual/opengl
	 media-libs/libvisual"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
