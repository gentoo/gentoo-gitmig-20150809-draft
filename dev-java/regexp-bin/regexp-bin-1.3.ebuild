# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp-bin/regexp-bin-1.3.ebuild,v 1.1 2004/07/30 21:33:07 axxo Exp $

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/jakarta-${PN/-bin}-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="1"
IUSE="doc"
LICENSE="Apache-1.1"
KEYWORDS="x86 ~ppc sparc amd64"
DEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/jakarta-${PN/-bin}-${PV}

src_install() {
	mv jakarta-regexp-${PV}.jar regexp-${PV}.jar
	dojar regexp-${PV}.jar
	use doc && dohtml -r docs/*
}
