# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.60.1-r1.ebuild,v 1.2 2006/01/19 12:00:51 cryos Exp $

inherit kde

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="javascript kde"
# kde: adds support for Konqueror's right-click actions

DEPEND="kde? ( || ( ( kde-base/libkonq kde-base/kdebase-kioslaves )
		    >=kde-base/kdebase-3.3 ) )
	javascript? ( kde-base/kjsembed )"

RDEPEND="${DEPEND}
	kde? ( || ( kde-base/konqueror >=kde-base/kdebase-3.3 ) )"

need-kde 3.3

src_install() {
	kde_src_install

	rm -f "${D}/${D}/usr/share/apps/krusader/krusaderui.rc"
}

pkg_postinst() {
	echo
	einfo "Krusader can use various external applications, including:"
	einfo "- KMail   (kde-base/kdepim)"
	einfo "- Kompare (kde-base/kdesdk)"
	einfo "- KDiff3  (app-misc/kdiff3)"
	einfo "- XXdiff  (dev-util/xxdiff)"
	einfo "- KRename (app-misc/krename)"
	einfo "- Eject   (virtual/eject)"
	echo
	einfo "It supports also quite a few archive formats, including:"
	einfo "- app-arch/arj"
	einfo "- app-arch/unarj"
	einfo "- app-arch/rar"
	einfo "- app-arch/zip"
	einfo "- app-arch/unzip"
	einfo "- app-arch/unace"
	echo
}
