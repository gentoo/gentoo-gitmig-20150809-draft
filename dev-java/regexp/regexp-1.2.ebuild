# Copyright 1999-2003 Gentoo Technologies, Inc.
# Copyright 2002 Jordan Armstrong <jordan@papercrane.net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp/regexp-1.2.ebuild,v 1.2 2003/02/13 10:22:27 vapier Exp $

S=${WORKDIR}/jakarta-regexp-${PV}
DESCRIPTION="Regexp is a 100% Pure Java Regular Expression package"
SRC_URI="http://jakarta.apache.org/builds/jakarta-regexp/release/v${PV}/jakarta-regexp-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
SLOT="1"
LICENSE="Apache-1.1"
DEPEND=">=virtual/jdk-1.3"
RDEPEND="$DEPEND"
KEYWORDS="x86"

src_compile() {
	cd build
	sh build-regexp.sh || die
}

src_install() {
	mv bin/jakarta-regexp-${PV}.jar bin/regexp-${PV}.jar
	dojar bin/regexp-${PV}.jar
	dohtml -r docs/*
}
