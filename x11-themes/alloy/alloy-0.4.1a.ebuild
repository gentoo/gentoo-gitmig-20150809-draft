# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/alloy/alloy-0.4.1a.ebuild,v 1.1 2003/09/10 13:38:20 tad Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A neat KDE 3.1 style based on the Java Alloy Look&Feel from Incors (http://www.incors.com)."
HOMEPAGE="http://www.kdelook.org/content/show.php?content=6304"
SRC_URI="http://www.kdelook.org/content/files/6304-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
DEPEND="kde-base/kdebase"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

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
