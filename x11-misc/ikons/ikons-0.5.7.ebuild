# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ikons/ikons-0.5.7.ebuild,v 1.1 2002/01/28 21:33:51 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

S="${WORKDIR}/iKons_057"

need-kde 2.1

DESCRIPTION="iKons iconset for KDE 2.x"
SRC_URI="http://www.kde-look.org/content/files/602-iKons_057_devel.tar.gz"
HOMEPAGE="http://users.skynet.be/bk369046/icon.htm"

src_compile() {

	return 1
}

src_install(){

	cd ${S}
	mkdir -p ${D}/${KDE2DIR}/share/icons/
	cp -rf ${S} ${D}/${KDE2DIR}/share/icons/iKons_057	

}
