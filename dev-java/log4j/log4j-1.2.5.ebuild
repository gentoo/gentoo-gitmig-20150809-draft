# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.5.ebuild,v 1.5 2003/02/13 10:21:47 vapier Exp $

S="${WORKDIR}/jakarta-${P}"

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache"
SLOT="1"
KEYWORDS="x86"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}"

src_install() {
	dojar dist/lib/*.jar
	dohtml -r docs/*
}

