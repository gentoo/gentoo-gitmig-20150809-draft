# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp/regexp-1.3.ebuild,v 1.8 2004/06/24 22:41:42 agriffis Exp $

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/jakarta-${PN}-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="1"
IUSE="doc"
LICENSE="Apache-1.1"
KEYWORDS="x86 ~ppc sparc amd64"
DEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/jakarta-${PN}-${PV}

src_install() {
	mv jakarta-regexp-${PV}.jar regexp-${PV}.jar
	dojar regexp-${PV}.jar
	use doc && dohtml -r docs/*
}
