# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mg4j-bin/mg4j-bin-0.8.2-r1.ebuild,v 1.3 2004/10/22 11:30:42 absinthe Exp $

inherit java-pkg

DESCRIPTION="MG4J (Managing Gigabytes for Java) is a collaborative effort aimed at providing a free Java implementation of inverted-index compression technique."
MY_P=${P/-bin}
SRC_URI="http://mg4j.dsi.unimi.it/${MY_P}-bin.tar.gz"
HOMEPAGE="http://mg4j.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.4
	>=dev-java/fastutil-3.1
	>=dev-java/violinstrings-1.0.1
	>=dev-java/jal-bin-20031117
	>=dev-java/colt-1.1.0
	>=dev-java/java-getopt-1.0.9"
S=${WORKDIR}/${MY_P}

src_compile () { :; }

src_install() {
	mv ${MY_P}.jar ${PN/-bin}.jar
	java-pkg_dojar ${PN/-bin}.jar
	use doc && java-pkg_dohtml -r docs/*
}

