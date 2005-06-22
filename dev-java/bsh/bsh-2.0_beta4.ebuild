# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-2.0_beta4.ebuild,v 1.1 2005/06/22 17:22:37 axxo Exp $

inherit java-pkg eutils

MY_DIST=${P/_beta/b}-src.jar

DESCRIPTION="BeanShell: A small embeddable Java source interpreter"
HOMEPAGE="http://www.beanshell.org"
SRC_URI="http://www.beanshell.org/${MY_DIST}
		 mirror://gentoo/beanshell-icon.png"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc gnome jikes junit kde readline"

DEPEND="${RDEPEND}
		>=dev-java/ant-core-1.5.4"
RDEPEND=">=virtual/jdk-1.4
	=dev-java/bsf-2.3*
	=dev-java/servletapi-2.4*
	readline? ( dev-java/libreadline-java )"

S=${WORKDIR}/BeanShell

src_unpack() {
	# Extract the sources
	cd ${WORKDIR}
	jar xf ${DISTDIR}/${MY_DIST}

	# Apply the build patch
	cd ${S}
	epatch ${FILESDIR}/bsh2-build.patch

	# Copy the needed files
	cp ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter ${S}

	# Patch with readline if required
	if use readline ; then
		# Apply the patch
		epatch ${FILESDIR}/bsh2-readline.patch

		# Update the classpath
		local ADD_CLASSPATH="`java-config -p libreadline-java`"
		sed -e "s:__ADD_CLASSPATH__:${ADD_CLASSPATH}:" \
		    -i ${S}/bsh.Console \
			-i ${S}/bsh.Interpreter
	fi
}

src_compile() {
	local classpath="bsf-2.3,servletapi-2.4"
	use readline && classpath="${classpath},libreadline-java"
	classpath=`java-config -p ${classpath}`

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
