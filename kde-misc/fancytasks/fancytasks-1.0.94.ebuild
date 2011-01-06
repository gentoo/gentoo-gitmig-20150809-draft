# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/fancytasks/fancytasks-1.0.94.ebuild,v 1.1 2011/01/06 18:18:35 dilfridge Exp $

EAPI=3
KDE_LINGUAS="da de en_GB es et fr km nds pl pt ru sv tr uk"
KDE_LINGUAS_DIR="applet/po"
# KDE_LINGUAS_DIR doesn't have support for multiple directories: containment/po
inherit kde4-base

DESCRIPTION="Task and launch representation plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php/Fancy+Tasks?content=99737"
SRC_URI="http://kde-look.org/CONTENT/content-files/99737-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep plasma-workspace)
	media-libs/qimageblitz
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

DOCS="CHANGELOG README TODO"

src_prepare() {
	kde4-base_src_prepare
	use linguas_pl || rm -f containment/po/pl.po
}
