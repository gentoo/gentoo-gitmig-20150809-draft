# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/alloy/alloy-0.3.ebuild,v 1.5 2004/03/30 10:31:00 mr_bones_ Exp $

inherit kde-base
need-kde 3.1

DESCRIPTION="A neat KDE 3.1 style based on the Java Alloy Look&Feel from Incors (http://www.incors.com)."
HOMEPAGE="http://www.kdelook.org/content/show.php?content=6304"
SRC_URI="http://www.kdelook.org/content/files/6304-${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
DEPEND="kde-base/kdebase"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile(){
	./configure --prefix=$KDEDIR || die
	emake || die
}

src_install(){
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst(){
	ewarn "HOW TO USE THIS THEME FOR KDE:"
	einfo ""
	einfo "Open the KDE-Menu and start the Control Center."
	einfo "Select \"Look and Feel\"."
	einfo "Select \"Style\" if the package you installed was a style, or select \"Theme Manager\" if the package you installed was a theme."
	einfo "Select your theme or style."
	einfo "Click \"Apply\""
	einfo ""
	einfo "Have fun! :-)"
}
