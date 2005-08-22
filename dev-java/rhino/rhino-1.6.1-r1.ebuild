# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.6.1-r1.ebuild,v 1.5 2005/08/22 19:03:30 gustavoz Exp $

inherit java-pkg eutils

MY_P="rhino1_6R1"
DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip http://dev.gentoo.org/~karltk/projects/java/distfiles/rhino-swing-ex-1.0.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="1.6"
KEYWORDS="~amd64 x86 sparc"
IUSE="jikes doc source"
S="${WORKDIR}/${MY_P}"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/xml-xmlbeans-20041217"
DEPEND="dev-java/ant-core
	>=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )
	${RDEPEND}"

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
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation error"
}

src_install() {
	dobin ${FILESDIR}/jsscript
	java-pkg_dojar build/*/js.jar
	use source && java-pkg_dosrc {src,toolsrc}/org
	use doc && java-pkg_dohtml -r docs/*
}
