# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.5_rc5.ebuild,v 1.2 2004/03/23 03:02:18 zx Exp $

inherit java-pkg

MY_P="rhino1_5R5RC1"
DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="jikes doc"
S="${WORKDIR}/${MY_P%%RC1}"
DEPEND="dev-java/ant
		>=virtual/jdk-1.3
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation error"
}

src_install() {
	dobin ${FILESDIR}/jsscript
	java-pkg_dojar build/*/js.jar
	use doc && dohtml -r docs/*
}
