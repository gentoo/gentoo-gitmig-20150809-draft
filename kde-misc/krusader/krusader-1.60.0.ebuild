# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.60.0.ebuild,v 1.6 2005/08/14 10:18:05 hansmi Exp $

inherit kde

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="javascript kde"
# kde: adds support for Konqueror's right-click actions

DEPEND="kde? ( || ( ( kde-base/libkonq kde-base/kdebase-kioslaves )
		    >=kde-base/kdebase-3.3 ) )
	javascript? ( kde-base/kjsembed )"

need-kde 3.3

src_compile() {
	sed -i -e 's/rcdir =/#rcdir =/' krusader/Makefile.in krusader/Makefile.am
	sed -i -e 's/rc_DATA =/#rc_DATA =/' krusader/Makefile.in krusader/Makefile.am

	kde_src_compile
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
	einfo ""
	einfo "It supports also quite a few archive formats, including:"
	einfo "- app-arch/arj"
	einfo "- app-arch/unarj"
	einfo "- app-arch/rar"
	einfo "- app-arch/zip"
	einfo "- app-arch/unzip"
	einfo "- app-arch/unace"
	echo
}
