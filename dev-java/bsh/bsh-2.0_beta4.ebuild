# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-2.0_beta4.ebuild,v 1.4 2005/07/09 16:00:08 axxo Exp $

inherit java-pkg eutils

MY_PV=${PV/_beta/b}
MY_DIST=${PN}-${MY_PV}-src.jar

DESCRIPTION="BeanShell: A small embeddable Java source interpreter"
HOMEPAGE="http://www.beanshell.org"
SRC_URI="http://www.beanshell.org/${MY_DIST} mirror://gentoo/beanshell-icon.png"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes readline source"

RDEPEND=">=virtual/jdk-1.4
	=dev-java/bsf-2.3*
	=dev-java/servletapi-2.4*
	readline? ( dev-java/libreadline-java )"
DEPEND="${RDEPEND}
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.6"

S=${WORKDIR}/BeanShell-${MY_PV}

src_unpack() {
	# Extract the sources
	cd ${WORKDIR}
	jar xf ${DISTDIR}/${MY_DIST} || die "failed to unpack"

	# Apply the build patch
	cd ${S}
	epatch ${FILESDIR}/bsh${MY_PV}-build.patch

	# Copy the needed files
	cp ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter ${S}

	# Patch with readline if required
	if use readline ; then
		# Apply the patch
		epatch ${FILESDIR}/bsh2-readline.patch
	fi
	local classpath="bsf-2.3,servletapi-2.4"
	use readline && classpath="${classpath},libreadline-java"
	classpath="$(java-pkg_getjars ${classpath})"
}

src_compile() {
	local classpath="bsf-2.3,servletapi-2.4"
	use readline && classpath="${classpath},libreadline-java"
	classpath="$(java-pkg_getjars ${classpath})"

	local antflags="jarall"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -lib ${classpath} ${antflags} || die "Compile Failed!"
}

src_install() {
	mv ${S}/dist/${P/_beta/b}.jar ${S}/dist/${PN}.jar
	java-pkg_dojar ${S}/dist/${PN}.jar

	newbin ${S}/bsh.Console bsh-console
	newbin ${S}/bsh.Interpreter bsh-interpreter

	use doc && java-pkg_dohtml -r ${S}/javadoc/*

	insinto /usr/share/icons/hicolor/scalable/apps
	doins ${DISTDIR}/beanshell-icon.png beanshell.png

	make_desktop_entry bsh-console "BeanShell Prompt" beanshell
}
