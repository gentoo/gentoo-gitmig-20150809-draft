# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.60.0_beta2.ebuild,v 1.1 2005/03/22 01:14:19 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE 3.x with many extras"
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="kde"
# Adds support for Konqueror's right-click actions

DEPEND="kde? ( || ( ( kde-base/libkonq kde-base/kdebase-kioslaves )
		    >=kde-base/kdebase-3.3 ) )
	x86? ( javascript? ( kde-base/kjsembed ) )"

need-kde 3.3

pkg_postinst() {
	echo
	einfo "Krusader can use some external applications, including:"
	einfo "- KMail   (kde-base/kdepim)"
	einfo "- Kompare (kde-base/kdesdk)"
	einfo "- KDiff3  (app-misc/kdiff3)"
	einfo "- XXdiff  (dev-util/xxdiff)"
	einfo "- KRename (app-misc/krename)"
	einfo "- Eject   (sys-apps/eject)"
	echo
	einfo "Also it supports quite a few archive formats. Please use this"
	einfo "command to install the more uncommon ones in the *nix world:"
	einfo "\"emerge app-arch/{arj,unarj,rar,zip,unzip,unace}\""
	echo
}
