# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/opcion/opcion-1.1.1.ebuild,v 1.4 2006/04/07 13:02:44 deltacow Exp $

inherit java-pkg

MY_P="Opcion_v${PV}"

DESCRIPTION="Free font viewer written in Java"
HOMEPAGE="http://opcion.sourceforge.net/"
SRC_URI="mirror://sourceforge/opcion/${MY_P}.jar"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${MY_P}.jar .
}

src_compile() {
	return
}

src_install() {
	java-pkg_dojar *.jar

	echo "#!/bin/sh" > ${T}/opcion
	echo "java -jar /usr/share/opcion/lib/${MY_P}.jar" >> ${T}/opcion
	dobin ${T}/opcion
}
