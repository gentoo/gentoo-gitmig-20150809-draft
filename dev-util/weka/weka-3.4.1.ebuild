# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weka/weka-3.4.1.ebuild,v 1.5 2004/11/03 11:49:42 axxo Exp $

inherit java-pkg

DESCRIPTION="A Java data mining package"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV//./-}.zip"
HOMEPAGE="http://www.cs.waikato.ac.nz/ml/weka/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND=">=virtual/jdk-1.4.1
		app-arch/unzip"
IUSE="doc"

S=${WORKDIR}/${PN}-3-4

src_compile() { :; }

src_install() {
	java-pkg_dojar *.jar || die "failed installing"

	dodir /usr/share/${PN}/data/
	cp data/* ${D}/usr/share/${PN}/data/
	use doc && java-pkg_dohtml -r doc/*
	dodoc README* COPYING CHANGELOG-${PV//./-}
	cp *.pdf ${D}/usr/share/doc/${P}/
}
