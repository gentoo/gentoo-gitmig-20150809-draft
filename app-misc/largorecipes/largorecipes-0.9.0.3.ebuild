# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/largorecipes/largorecipes-0.9.0.3.ebuild,v 1.1 2003/05/23 16:31:46 tberman Exp $

# Based on an original ebuild by Per Wigren <wigren@home.se>

inherit java-pkg

DESCRIPTION="LargoRecipes is an application for managing recipes."
SRC_URI="mirror://sourceforge/largorecipes/${PN}-0.9.0.1.jar
         mirror://sourceforge/largorecipes/${PN}patch-${PV}.jar"
HOMEPAGE="http://largorecipes.sourceforge.net/"

IUSE=""
DEPEND=">=virtual/jre-1.4"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

LICENSE="GPL-2"

src_unpack() {
	mkdir -p ${S}
	cp ${DISTDIR}/${PN}-0.9.0.1.jar ${S}
	cp ${DISTDIR}/${PN}patch-0.9.0.3.jar ${S}
}

src_compile() {
	einfo "No compilation needed (for now)"
}

src_install() {

    dobin ${FILESDIR}/largorecipes
    java-pkg_dojar ${PN}-0.9.0.1.jar
    java-pkg_dojar ${PN}patch-0.9.0.3.jar
}
