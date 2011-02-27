# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/panini/panini-0.71.104.ebuild,v 1.1 2011/02/27 07:08:43 radhermit Exp $

EAPI=3

inherit qt4-r2 eutils

MY_P="${P/p/P}-src"
DESCRIPTION="OpenGL-based panoramic image viewer"
HOMEPAGE="http://sourceforge.net/projects/pvqt/"
SRC_URI="mirror://sourceforge/pvqt/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-opengl:4
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_P}"

src_install() {
	newbin Panini panini
	dodoc panini-usage.txt panini-0.71-release.txt
	domenu "${FILESDIR}"/${PN}.desktop
	newicon ui/panini-icon-blue.jpg ${PN}.jpg
}
