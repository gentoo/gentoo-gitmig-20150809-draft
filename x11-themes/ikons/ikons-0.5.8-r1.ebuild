# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ikons/ikons-0.5.8-r1.ebuild,v 1.6 2003/09/06 07:28:56 msterret Exp $
inherit kde
set-kdedir 3

S="${WORKDIR}/iKons_058"
DESCRIPTION="iKons iconset for KDE 2.x"
SRC_URI="http://www.kde-look.org/content/files/602-iKons_058_devel.tar.gz"
HOMEPAGE="http://users.skynet.be/bk369046/icon.htm"
KEYWORDS="x86 sparc alpha"
SLOT="0"
LICENSE="as-is"


src_compile() {

	return 1
}

src_install(){

	cd ${S}

	dodir $PREFIX/share/icons
	cp -rf ${S} ${D}/${PREFIX}/share/icons/iKons_058

}
