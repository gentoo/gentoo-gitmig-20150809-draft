# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp/regexp-1.2.ebuild,v 1.3 2003/03/01 04:52:55 vapier Exp $

S=${WORKDIR}/jakarta-regexp-${PV}
DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="http://jakarta.apache.org/builds/jakarta-regexp/release/v${PV}/jakarta-regexp-${PV}.tar.gz"
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
