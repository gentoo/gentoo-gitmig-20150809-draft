# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.6.1-r1.ebuild,v 1.1 2005/01/29 21:16:24 luckyduck Exp $

inherit java-pkg eutils

MY_P="rhino1_6R1"
DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip http://dev.gentoo.org/~karltk/projects/java/distfiles/rhino-swing-ex-1.0.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="1.6"
KEYWORDS="~x86 ~amd64"
IUSE="jikes doc"
S="${WORKDIR}/${MY_P}"
DEPEND="dev-java/ant-core
	>=virtual/jdk-1.4
	app-arch/unzip
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/xml-xmlbeans-20041217"

src_unpack() {
	unpack ${MY_P}.zip
	cd ${S}

	epatch ${FILESDIR}/rhino-1.6-gentoo.patch

	cp ${DISTDIR}/rhino-swing-ex-1.0.zip swingExSrc.zip

	mkdir lib/ && cd lib/
	java-pkg_jar-from xml-xmlbeans-1 xbean.jar
}

src_compile() {
	local antflags="jar"
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "compilation error"
}

src_install() {
	dobin ${FILESDIR}/jsscript
	java-pkg_dojar build/*/js.jar
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
