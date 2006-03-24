# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dekorator/dekorator-0.2.ebuild,v 1.3 2006/03/24 15:07:13 seemant Exp $

inherit kde

MY_P="${PN/k/K}-${PV}-fix1"
DESCRIPTION="DeKorator is a native window style for KDE 3.2+"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=31447"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
S="${WORKDIR}/${MY_P}"

need-kde 3.3

pkg_postinst() {
	einfo "To use deKorator, open KDE's Control Center, go to"
	einfo "Appearance & Themes, select Window Decorations,"
	einfo "deKorator. For more information, see"
	einfo "${HOMEPAGE}"
}
