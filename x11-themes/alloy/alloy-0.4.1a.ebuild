# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/alloy/alloy-0.4.1a.ebuild,v 1.7 2005/01/15 00:20:39 danarmak Exp $

inherit kde

DESCRIPTION="A neat KDE 3.1 style based on the Java Alloy Look&Feel from Incors (http://www.incors.com)."
HOMEPAGE="http://www.kdelook.org/content/show.php?content=6304"
SRC_URI="http://www.kdelook.org/content/files/6304-${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"
IUSE=""

DEPEND="|| ( kde-base/kdebase-meta kde-base/kdebase )"
need-kde 3.1


pkg_postinst(){
	ewarn "HOW TO USE THIS THEME FOR KDE:"
	einfo ""
	einfo "Open the KDE-Menu and start the Control Center."
	einfo "Select \"Look and Feel\"."
	einfo "Select \"Style\" if the package you installed was a style, or"
	einfo "select \"Theme Manager\" if the package you installed was a theme."
	einfo "Select your theme or style."
	einfo "Click \"Apply\""
	einfo ""
	einfo "Have fun! :-)"
}
