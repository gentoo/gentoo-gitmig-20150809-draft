# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.7.4.ebuild,v 1.2 2012/01/09 15:40:42 phajdan.jr Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop thumbnail"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep libkonq)
	semantic-desktop? ( >=dev-libs/shared-desktop-ontologies-0.2 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kfind)
"
PDEPEND="
	thumbnail? (
		$(add_kdebase_dep thumbnailers)
		|| (
			$(add_kdebase_dep ffmpegthumbs)
			$(add_kdebase_dep mplayerthumbs)
		)
	)
"

KMLOADLIBS="libkonq"

RESTRICT="test"
# bug 393129

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-meta_src_configure
}
