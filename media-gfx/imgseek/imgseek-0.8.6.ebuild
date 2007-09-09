# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imgseek/imgseek-0.8.6.ebuild,v 1.1 2007/09/09 15:02:11 coldwind Exp $

NEED_PYTHON=2.2

inherit eutils distutils

MY_PN="imgSeek"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Photo collection manager with content-based search."
HOMEPAGE="http://imgseek.sourceforge.net/"
SRC_URI="mirror://sourceforge/imgseek/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-python/PyQt-3.5
	dev-python/imaging"
RDEPEND="${DEPEND}"

DOCS="ChangeLog COPYING AUTHORS README THANKS"

src_install() {
	distutils_src_install
	insinto /usr/share/${MY_PN}
	doicon ${MY_PN}.png
	make_desktop_entry "${MY_PN} %F" ${MY_PN} ${MY_PN}.png "Graphics;Qt"
}
