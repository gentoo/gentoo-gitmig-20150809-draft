# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aspectj/aspectj-1.2-r2.ebuild,v 1.4 2008/01/10 22:02:11 caster Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="AspectJ is a seemless extension to the Java programming language for Aspect Oriented Programming (AOP)"
SRC_URI="mirror://gentoo/aspectj-CVS-V1_2_0.tar.bz2"
HOMEPAGE="http://www.eclipse.org/aspectj/"
CDEPEND="dev-java/bcel
	=dev-java/junit-3.8*
	dev-java/jython
	=dev-java/jakarta-regexp-1.3*
	=dev-java/saxon-6.5*
	dev-java/ant-core"
DEPEND=">=virtual/jdk-1.3
	sys-apps/findutils
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.3
	${CDEPEND}"

SLOT="0"
LICENSE="CPL-1.0 Apache-1.1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

# Welcome to the AspectJ ebuild.  An upstream source archive is not
# available directly.  The AspectJ source .tar.bz2 snapshot is taken
# from CVS with the following command:
#
#	 cvs -z3 -d:pserver:anonymous@dev.eclipse.org:/home/technology \
#		 co -rV1_2_0 org.aspectj/modules
#
# The source is then patched so that the installed binaries have
# version information which reflects the tagged source release.	 The
# AspectJ build system does not do this automatically.
#
# Useful documentation for this port:
#
#	 http://dev.eclipse.org/viewcvs/index.cgi/~checkout~/org.aspectj/modules/build/readme-build-and-test-aspectj.html?rev=HEAD&content-type=text/html&cvsroot=Technology_Project
#
#	 http://dev.eclipse.org/viewcvs/index.cgi/~checkout~/org.aspectj/modules/build/release-checklist.txt?rev=HEAD&content-type=text/plain&cvsroot=Technology_Project
#

S=${WORKDIR}/org.aspectj/modules

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/aspectj-${PV}-version-gentoo.patch
	epatch ${FILESDIR}/aspectj-${PV}-fix-javadoc.patch
	epatch ${FILESDIR}/aspectj-${PV}-fix-examples-build.xml.patch
	sed -i "s,DEVELOPMENT,${PV},g" build/build-properties.xml
	sed -i -e "s,@PV@,${PV},g" -e "s,@PV_LONG@,${PV} (Gentoo Build),g" \
		org.aspectj.ajdt.core/src/org/aspectj/ajdt/ajc/messages.properties

	cd lib/ant/lib
		rm *.jar
		java-pkg_jar-from ant-core

	cd ../../commons
		rm *.jar

	cd ../bcel
		rm *.jar
		java-pkg_jar-from bcel

	cd ../jdiff
		rm *.jar

	cd ../junit
		rm *.jar
		java-pkg_jar-from junit

	cd ../jython
		rm *.jar
		java-pkg_jar-from jython

	cd ../regexp
		rm *.jar
		java-pkg_jar-from jakarta-regexp-1.3

	cd ../saxon
		rm *.jar
		java-pkg_jar-from saxon-6.5
}

src_compile() {
	cd build
	eant
}

src_install() {
	mkdir aspectj-unpack
	java -jar aj-build/dist/aspectj-${PV}.jar -to aspectj-unpack
	cd aspectj-unpack
	java-pkg_dojar lib/*.jar
	dobin ${FILESDIR}/{ajc,ajbrowser}

	dohtml doc/*.html
	dohtml README-AspectJ.html
	if use doc; then
		cp -R doc/{devguide,api,progguide} ${D}/usr/share/doc/${PF}/html
		cp -R doc/examples ${D}/usr/share/doc/${PF}
		cp doc/*.pdf ${D}/usr/share/doc/${PF}
	fi
}
