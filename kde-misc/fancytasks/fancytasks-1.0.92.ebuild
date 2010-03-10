# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/fancytasks/fancytasks-1.0.92.ebuild,v 1.1 2010/03/10 00:09:40 nelchael Exp $

EAPI=2
KDE_LINGUAS="de pl pt ru sv uk"
KDE_LINGUAS_DIR="applet/po"
# KDE_LINGUAS_DIR doesn't have support for multiple directories: containment/po
inherit kde4-base

DESCRIPTION="A task and launch representation plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php/Fancy+Tasks?content=99737"
SRC_URI="http://kde-look.org/CONTENT/content-files/99737-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXcomposite
	kde-base/qimageblitz
	>=kde-base/plasma-workspace-${KDE_MINIMAL}"

DOCS="CHANGELOG README TODO"

src_prepare() {
	kde4-base_src_prepare
	use linguas_pl || rm -f containment/po/pl.po
}
