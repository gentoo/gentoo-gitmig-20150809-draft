# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mg4j/mg4j-0.8.2.ebuild,v 1.3 2004/07/30 20:14:04 axxo Exp $

inherit java-pkg

DESCRIPTION="MG4J (Managing Gigabytes for Java) is a collaborative effort aimed at providing a free Java implementation of inverted-index compression technique."
SRC_URI="http://mg4j.dsi.unimi.it/${P}-bin.tar.gz"
HOMEPAGE="http://mg4j.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.4
	>=dev-java/fastutil-3.1
	>=dev-java/violinstrings-1.0.1
	>=dev-java/jal-bin-20031117
	>=dev-java/colt-1.1.0
	>=dev-java/java-getopt-1.0.9"

src_compile () { :; }

src_install() {
	mv ${P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	use doc && dohtml -r docs/*
}

