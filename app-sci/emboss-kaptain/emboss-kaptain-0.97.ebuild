# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/emboss-kaptain/emboss-kaptain-0.97.ebuild,v 1.1 2004/10/31 03:23:34 ribosome Exp $

DESCRIPTION="Graphical interfaces for EMBOSS and EMBASSY programs"
HOMEPAGE="http://userpage.fu-berlin.de/~sgmd/"
SRC_URI="http://genetik.fu-berlin.de/sgmd/EMBOSS.kaptns_${PV}.tar.gz"
LICENSE="GPL-1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/EMBOSS.kaptns_${PV}

DEPEND="app-misc/kaptain
	app-editors/nedit
	app-sci/emboss
	app-sci/embassy-phylip
	app-sci/embassy-domainatrix"

src_compile() {
	cd EMBOSS
	for i in *; do
		cd "${i}"
		for j in *.desktop; do
			sed -i -e 's%Exec=%Exec=kaptain /usr/share/emboss-kaptain/%' ${j}
		done
		cd ${S}/EMBOSS
	done
	cd ${S}/Domainatrix/Domainatrix
	for i in *.desktop; do
		sed -i -e 's%Exec=%Exec=kaptain /usr/share/emboss-kaptain/%' ${i}
	done
}

src_install() {
	exeinto /usr/share/${PN}
	doexe *.kaptn
	doexe Domainatrix/*.kaptn
	mkdir -p ${D}/usr/share/applnk/EMBOSS/Domainatrix
	cp -r EMBOSS/* ${D}/usr/share/applnk/EMBOSS
	cp -r Domainatrix/Domainatrix/* ${D}/usr/share/applnk/EMBOSS/Domainatrix
}
