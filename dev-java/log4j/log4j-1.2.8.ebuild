# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.8.ebuild,v 1.8 2004/03/23 03:30:39 zx Exp $

inherit java-pkg

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.2"
S="${WORKDIR}/jakarta-${P}"

src_compile() { :; }

src_install() {
	java-pkg_dojar dist/lib/*.jar
	use doc && dohtml -r docs/*
}

