# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-2.0_beta4-r1.ebuild,v 1.1 2006/07/04 19:26:05 nichoj Exp $

inherit java-pkg-2 eutils java-ant-2

MY_PV=${PV/_beta/b}
MY_DIST=${PN}-${MY_PV}-src.jar

DESCRIPTION="BeanShell: A small embeddable Java source interpreter"
HOMEPAGE="http://www.beanshell.org"
SRC_URI="http://www.beanshell.org/${MY_DIST} mirror://gentoo/beanshell-icon.png"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc readline source"

RDEPEND=">=virtual/jdk-1.4
	=dev-java/bsf-2.3*
	=dev-java/servletapi-2.4*
	readline? ( dev-java/libreadline-java )"
DEPEND="${RDEPEND}
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.6"

S=${WORKDIR}/BeanShell-${MY_PV}

ant_src_unpack() {
	jar xf ${DISTDIR}/${MY_DIST} || die "failed to unpack"
	cd ${S}

	epatch ${FILESDIR}/bsh${MY_PV}-build.patch

	cp ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter ${S}

	use readline && epatch ${FILESDIR}/bsh2-readline.patch
}

src_compile() {
	local classpath="bsf-2.3,servletapi-2.4"
	use readline && classpath="${classpath},libreadline-java"

	eant -lib $(java-pkg_getjars ${classpath}) $(use_doc) jarall
}

src_install() {
	java-pkg_newjar ${S}/dist/${P/_beta/b}.jar

	use source && java-pkg_dosrc src/bsh

	java-pkg_dolauncher bsh-console --main bsh.Console
	java-pkg_dolauncher bsh-interpreter --main bsh.Interpreter

	use doc && java-pkg_dohtml -r ${S}/javadoc/*

	newicon ${DISTDIR}/beanshell-icon.png beanshell.png

	make_desktop_entry bsh-console "BeanShell Prompt" beanshell
}
