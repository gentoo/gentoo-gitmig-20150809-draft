# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molsketch/molsketch-0.2.0.ebuild,v 1.1 2010/11/02 09:20:03 jlec Exp $

EAPI=3

inherit cmake-utils

MY_P="${P/m/M}-Source"

DESCRIPTION="A drawing tool for 2D molecular structures"
HOMEPAGE="http://molsketch.sourceforge.net/"
SRC_URI="mirror://sourceforge/molsketch/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sci-chemistry/openbabel
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-assistant:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	local mycmakeargs="
	  -DOPENBABEL2_INCLUDE_DIR=${EPREFIX}/usr/include/openbabel-2.0"
	cmake-utils_src_configure
}
