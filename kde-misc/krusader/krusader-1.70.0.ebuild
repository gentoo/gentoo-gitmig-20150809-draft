# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.70.0.ebuild,v 1.8 2006/04/12 07:58:23 cryos Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="javascript kde"

DEPEND="kde? ( || ( ( kde-base/libkonq kde-base/kdebase-kioslaves )
		    kde-base/kdebase ) )
	javascript? ( kde-base/kjsembed )"
need-kde 3.4

pkg_postinst() {
	echo
	einfo "Krusader can use various external applications, including:"
	einfo "- KMail   (kde-base/kdepim)"
	einfo "- Kompare (kde-base/kdesdk)"
	einfo "- KDiff3  (kde-misc/kdiff3)"
	einfo "- XXdiff  (dev-util/xxdiff)"
	einfo "- KRename (kde-misc/krename)"
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
	ewarn "IMPORTANT: Please remove your ~/.kde/share/apps/krusader/krusaderui.rc file"
	ewarn "after installation!!! (Else you won't see new menu entries. But please note:"
	ewarn "This will also reset all your changes on toolbars and shortcuts!)"
	echo
}

src_compile() {
	local myconf="$(use_with kde konqueror) $(use_with javascript) --with-kiotar"
	kde_src_compile
}
