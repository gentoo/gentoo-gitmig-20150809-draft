# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/alloy/alloy-0.5.ebuild,v 1.8 2004/08/30 19:44:41 pvdabeel Exp $

inherit kde


DESCRIPTION="A neat KDE style based on the Java Alloy Look&Feel from Incors (http://www.incors.com)."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10605"
SRC_URI="http://www.kde-look.org/content/files/10605-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha ~amd64"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2
	>=x11-libs/qt-3.3.0"
need-kde 3.2

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
