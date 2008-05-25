# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/khmer/khmer-5.0.ebuild,v 1.1 2008/05/25 02:55:16 dirtyepic Exp $

inherit font

DESCRIPTION="Fonts for the Khmer language of Cambodia"
HOMEPAGE="http://www.khmeros.info/drupal/?q=en/download/fonts"
SRC_URI="mirror://sourceforge/khmer/All_KhmerOS_${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/All_KhmerOS_${PV}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

pkg_postinst() {
	font_pkg_postinst
	echo
	elog "To prefer using Khmer OS fonts with >=fontconfig-2.5.91, run:"
	elog
	elog "	eselect fontconfig enable 65-khmer"
	elog
	echo
}
