# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/korilla/korilla-1.3.4-r1.ebuild,v 1.7 2012/07/29 18:28:07 armin76 Exp $

DESCRIPTION="Kool Gorilla Icon Set for KDE"
SRC_URI="mirror://gentoo/Korilla-v${PV}.tar.bz2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7264"
KEYWORDS="amd64 ppc x86"
IUSE=""
SLOT="0"
LICENSE="as-is"

S="${WORKDIR}/Kool.Gorilla"

src_install(){
	dodir /usr/share/icons/
	cp -r "${S}" "${D}/usr/share/icons/"
}
