# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.5_rc4.ebuild,v 1.2 2003/05/29 00:55:53 tberman Exp $

# This should be dynamic

inherit java-pkg

IUSE="doc"

MY_P="rhino1_5R4_1"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/js/${MY_P//_/}.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=virtual/jdk-1.3
	dev-java/ant"

src_compile() {
	ant jar
}


src_install() {
	java-pkg_dojar build/${MY_P}/js.jar
	if [ "` use doc `" ]; then
		dohtml -r docs/*
	fi
}
