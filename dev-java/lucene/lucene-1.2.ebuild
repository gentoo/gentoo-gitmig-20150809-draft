# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.2.ebuild,v 1.2 2003/02/13 10:21:57 vapier Exp $

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
