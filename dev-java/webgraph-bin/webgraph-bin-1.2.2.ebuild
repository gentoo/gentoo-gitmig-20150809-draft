# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/webgraph-bin/webgraph-bin-1.2.2.ebuild,v 1.2 2004/08/03 12:07:00 dholm Exp $

inherit java-pkg

DESCRIPTION="WebGraph is a framework to study the web graph. It provides simple ways to manage very large graphs, exploiting modern compression techniques."
SRC_URI="http://webgraph.dsi.unimi.it/${P/-bin}-bin.tar.gz"
HOMEPAGE="http://webgraph.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.4
		>=dev-java/mg4j-bin-0.8.2"

src_compile() { :; }

src_install() {
	mv ${P/-bin}.jar ${PN/-bin}.jar
	java-pkg_dojar ${PN/-bin}.jar
	use doc && dohtml -r docs/*
}

