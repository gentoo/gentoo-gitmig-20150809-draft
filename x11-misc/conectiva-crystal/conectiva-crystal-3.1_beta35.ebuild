# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/x11-misc/conectiva-crystal/conectiva-crystal-3.1_beta.ebuild,v 1.1 2002/05/18 10:06:55 verwilst Exp

S="${WORKDIR}/Crystal"
DESCRIPTION="Conectiva Crystal - Icon theme"
SRC_URI="http://www.conectiva.com.br/~nucleodecriacao/conectiva_crystal_beta3.1.tar.gz"
HOMEPAGE="http://www.conectiva.com.br"

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
