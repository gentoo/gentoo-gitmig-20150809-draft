# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.2.ebuild,v 1.1 2002/10/25 23:29:44 blizzy Exp $

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="http://jakarta.apache.org/builds/jakarta-${PN}/release/v${PV//_/-}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=virtual/jdk-1.1"

S="${WORKDIR}/${P}"

src_install() {
	mv ${P}.jar lucene.jar
	dojar lucene.jar
	dodoc CHANGES.txt LICENSE.txt README.txt TODO.txt
	dohtml -r docs/*
}
