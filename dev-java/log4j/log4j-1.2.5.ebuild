# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.5.ebuild,v 1.2 2002/10/04 05:11:29 vapier Exp $

S="${WORKDIR}/jakarta-${P}"

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache"
SLOT="1"
KEYWORDS="*"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}"

src_compile() {
	echo "nothing to compile"
}

src_install() {
	dojar dist/lib/*.jar
	dohtml -r docs/*
}

