# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp/regexp-1.2.ebuild,v 1.5 2003/04/26 11:11:28 absinthe Exp $

S=${WORKDIR}/jakarta-${PN}-${PV}
DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/jakarta-${PN}-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"

SLOT="1"
LICENSE="Apache-1.1"
KEYWORDS="x86"

DEPEND=">=virtual/jdk-1.3"

src_compile() {
	cd build
	sh build-regexp.sh || die
}

src_install() {
	mv bin/jakarta-regexp-${PV}.jar bin/regexp-${PV}.jar
	dojar bin/regexp-${PV}.jar
	dohtml -r docs/*
}
