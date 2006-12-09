# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.6.1-r3.ebuild,v 1.5 2006/12/09 09:24:24 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_P="rhino1_6R1"
DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip http://dev.gentoo.org/~karltk/projects/java/distfiles/rhino-swing-ex-1.0.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="1.6"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc source"
S="${WORKDIR}/${MY_P}"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/xml-xmlbeans-20041217"
DEPEND="dev-java/ant-core
	>=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )
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
	eant jar
}

src_install() {
	java-pkg_dolauncher jsscript-${SLOT} \
		--main org.mozilla.javascript.tools.shell.Main
	java-pkg_dojar build/*/js.jar
	use source && java-pkg_dosrc {src,toolsrc}/org
	use doc && java-pkg_dohtml -r docs/*
}
