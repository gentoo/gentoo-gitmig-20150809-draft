# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.50_beta1.ebuild,v 1.1 2004/10/18 15:42:11 carlo Exp $

inherit flag-o-matic kde

MY_P=${P/_/"-"}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE 3.x with many extras"
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

# Adds support for Konqueror's right-click actions
IUSE="kde"
DEPEND="kde? ( >=kde-base/kdebase-3.2 )"

need-kde 3.2

src_compile() {
	use amd64 && append-flags -fPIC
	kde_src_compile	configure make
}

pkg_postinst() {
	echo ""
	einfo "Krusader can use some external applications, which includes"
	einfo "- KMail   (kde-base/kdepim)"
	einfo "- Kompare (kde-base/kdesdk)"
	einfo "- KDiff3  (app-misc/kdiff3)"
	einfo "- XXdiff  (dev-util/xxdiff)"
	einfo "- KRename (app-misc/krename)"
	einfo "- Eject   (sys-apps/eject)"

	einfo "and supports quite a few archive formats. Please use the following"
	einfo "command to install the more uncommon ones in the *nix world:"
	einfo "\"emerge app-arch/{arj,unarj,rar,unrar,zip,unzip,unace}\""
	echo ""
}
