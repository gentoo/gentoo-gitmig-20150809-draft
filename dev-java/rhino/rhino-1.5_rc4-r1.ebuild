# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.5_rc4-r1.ebuild,v 1.1 2004/01/23 15:43:58 mkennedy Exp $

# This should be dynamic

inherit java-pkg

IUSE="doc"

MY_P="rhino1_5R4_1"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Rhino is an implementation of JavaScript written entirely in Java."
SRC_URI="ftp://ftp.mozilla.org/pub/js/${MY_P//_/}.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"

RDEPEND=">=virtual/jdk-1.3
	dev-java/ant"

src_compile() {
	ant jar
}

src_install() {
	dobin ${FILESDIR}/jsscript
	java-pkg_dojar build/${MY_P}/js.jar
	if use doc; then
		dohtml -r docs/*
	fi
}
