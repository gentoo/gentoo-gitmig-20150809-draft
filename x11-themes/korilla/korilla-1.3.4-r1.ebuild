# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/korilla/korilla-1.3.4-r1.ebuild,v 1.2 2006/07/23 02:18:42 lu_zero Exp $

DESCRIPTION="Kool Gorilla Icon Set for KDE"
SRC_URI="mirror://gentoo/Korilla-v${PV}.tar.bz2"
HOMEPAGE="http://localhost/" # Not available and repoman annoys
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""
SLOT="0"
LICENSE="as-is"

S="${WORKDIR}/Kool.Gorilla"

src_install(){
	dodir /usr/share/icons/
	cp -r "${S}" "${D}/usr/share/icons/"
}
