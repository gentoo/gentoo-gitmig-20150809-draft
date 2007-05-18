# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-2.0_beta4-r2.ebuild,v 1.1 2007/05/18 17:57:42 caster Exp $

inherit java-pkg-2 eutils java-ant-2

MY_PV=${PV/_beta/b}
MY_DIST=${PN}-${MY_PV}-src.jar

DESCRIPTION="BeanShell: A small embeddable Java source interpreter"
HOMEPAGE="http://www.beanshell.org"
SRC_URI="http://www.beanshell.org/${MY_DIST} mirror://gentoo/beanshell-icon.png"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc readline source"

RDEPEND=">=virtual/jdk-1.4
	=dev-java/servletapi-2.4*
	readline? ( dev-java/libreadline-java )"
DEPEND="${RDEPEND}
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.6"

S=${WORKDIR}/BeanShell-${MY_PV}

src_unpack() {
	jar xf ${DISTDIR}/${MY_DIST} || die "failed to unpack"
	cd ${S}

	epatch ${FILESDIR}/bsh${MY_PV}-build.patch

	cp ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter ${S}

	use readline && epatch ${FILESDIR}/bsh2-readline.patch

	cd "${S}/lib/"
	rm -v *.jar
	java-pkg_jar-from servletapi-2.4
	use readline && java-pkg_jar-from libreadline-java
}

EANT_BUILD_TARGET="jarall"

src_install() {
	java-pkg_newjar ${S}/dist/${P/_beta/b}.jar

	use source && java-pkg_dosrc src/bsh

	java-pkg_dolauncher bsh-console --main bsh.Console
	java-pkg_dolauncher bsh-interpreter --main bsh.Interpreter

	use doc && java-pkg_dojavadoc ${S}/javadoc

	newicon ${DISTDIR}/beanshell-icon.png beanshell.png

	make_desktop_entry bsh-console "BeanShell Prompt" beanshell
}
