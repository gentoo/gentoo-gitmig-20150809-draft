# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.8.ebuild,v 1.4 2004/01/16 12:12:10 strider Exp $

S="${WORKDIR}/jakarta-${P}"

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 sparc ~ppc"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}"

src_install() {
	dojar dist/lib/*.jar
	dohtml -r docs/*
}

