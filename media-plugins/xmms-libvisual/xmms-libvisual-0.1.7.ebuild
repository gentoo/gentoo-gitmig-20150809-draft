# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-libvisual/xmms-libvisual-0.1.7.ebuild,v 1.1 2004/10/21 04:40:56 eradicator Exp $

IUSE=""

XMMS_PN="libvisual-xmms"
XMMS_PV=${PV}
XMMS_P="${XMMS_PN}-${XMMS_PV}"
XMMS_S="${XMMS_WORKDIR}/${XMMS_P}"

BMP_PN="libvisual-bmp"
BMP_PV="0.1.0"
BMP_P="${BMP_PN}-${BMP_PV}"
BMP_S="${BMP_WORKDIR}/${BMP_P}"

XMMS_SRC_URI="mirror://sourceforge/libvisual/${XMMS_P}.tar.gz"
BMP_SRC_URI="mirror://sourceforge/libvisual/${BMP_P}.tar.gz"

inherit xmms-plugin

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."
HOMEPAGE="http://libvisual.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

DEPEND="media-libs/libsdl
	virtual/opengl
	media-libs/libvisual"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	xmms-plugin_src_install

	if [ "$(get_libdir)" != "lib" ]; then
		mv ${D}/usr/lib ${D}/usr/$(get_libdir)
	fi
}
