# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/conectiva-crystal/conectiva-crystal-3.1_beta37.ebuild,v 1.4 2002/07/22 12:55:05 aliz Exp $

S="${WORKDIR}/Crystal"
DESCRIPTION="Conectiva Crystal - Icon theme"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/crystal-3.1_beta3.7.tar.gz"
HOMEPAGE="http://www.conectiva.com.br"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

DEPEND=""
RDEPEND=$DEPEND

src_compile() {

	return 1
}

src_install(){

	cd ${S}
	if [ -d ${KDE2DIR} ] ; then
	mkdir -p ${D}/${KDE2DIR}/share/icons/
	cp -rf ${S} ${D}/${KDE2DIR}/share/icons/Crystal
	fi

	if [ -d ${KDE3DIR} ] ; then
        mkdir -p ${D}/${KDE3DIR}/share/icons/
        cp -rf ${S} ${D}/${KDE3DIR}/share/icons/Crystal
        fi

}
