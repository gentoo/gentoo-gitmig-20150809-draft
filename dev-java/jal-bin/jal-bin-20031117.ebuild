# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jal-bin/jal-bin-20031117.ebuild,v 1.1 2004/07/30 20:12:24 axxo Exp $

inherit java-pkg

DESCRIPTION="Jal is a partial port of the STL by the C++ Standard Template Library."
SRC_URI="http://vigna.dsi.unimi.it/jal/${P/-bin}-bin.tar.gz"
HOMEPAGE="http://vigna.dsi.unimi.it/jal/"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.4
	>=dev-java/fastutil-3.1"

src_compile () { :; }

src_install() {
	mv ${P/-bin}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	use doc && dohtml -r docs/*
}

