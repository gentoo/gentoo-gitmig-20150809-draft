# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ikons/ikons-0.5.8.ebuild,v 1.6 2002/08/14 23:44:15 murphy Exp $

S="${WORKDIR}/iKons_058"
DESCRIPTION="iKons iconset for KDE 2.x"
SRC_URI="http://www.kde-look.org/content/files/602-iKons_058_devel.tar.gz"
HOMEPAGE="http://users.skynet.be/bk369046/icon.htm"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="as-is"

src_compile() {

	return 1
}

src_install(){

	cd ${S}
	if [ -d ${KDE2DIR} ] ; then
	mkdir -p ${D}/${KDE2DIR}/share/icons/
	cp -rf ${S} ${D}/${KDE2DIR}/share/icons/iKons_058	
	fi

	if [ -d ${KDE3DIR} ] ; then
	mkdir -p ${D}/${KDE3DIR}/share/icons/
	cp -rf ${S} ${D}/${KDE3DIR}/share/icons/iKons_058
	fi

}
