# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aspectj/aspectj-1.1.1.ebuild,v 1.1 2004/04/12 21:12:20 mkennedy Exp $

inherit java-pkg

DESCRIPTION="AspectJ is a seemless extension to the Java programming language for Aspect Oriented Programming (AOP)"
SRC_URI="mirror://gentoo/aspectj-CVS-V1_1_1.tar.bz2"
HOMEPAGE="http://www.eclipse.org/aspectj/"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant"
SLOT="0"
LICENSE="CPL-1.0 Apache-1.1"
KEYWORDS="~x86"
IUSE="doc"

# Welcome to the AspectJ ebuild.  An upstream source archive is not
# available directly.  The AspectJ source .tar.bz2 snapshot is taken
# from CVS with the following command:
#
#    cvs -z3 -d:pserver:anonymous@dev.eclipse.org:/home/technology \
#        co -rV1_1_1 org.aspectj/modules
#
# The source is then patched so that the installed binaries have
# version information which reflects the tagged source release.  The
# AspectJ build system does not do this automatically.

S=${WORKDIR}/org.aspectj/modules

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/aspectj-${PV}-version-gentoo.patch
	cd ${S}
	sed -i "s,DEVELOPMENT,${PV},g" build/build-properties.xml
	sed -i -e "s,@PV@,${PV},g" -e "s,@PV_LONG@,${PV} (Gentoo Build),g" \
		org.aspectj.ajdt.core/src/org/aspectj/ajdt/ajc/messages.properties
}

src_compile() {
	cd build
	ant -f build.xml || die
}

src_install () {
	mkdir aspectj-unpack
	java -jar aj-build/dist/aspectj-${PV}.jar -to aspectj-unpack
	cd aspectj-unpack
	java-pkg_dojar lib/*.jar
	dobin ${FILESDIR}/{ajc,ajbrowser}

	dohtml doc/*.html
	cp *.html ${D}/usr/share/doc/${PF}/
	if use doc; then
		cp -R doc/{devguide,api,progguide} ${D}/usr/share/doc/${PF}/html
		cp -R doc/examples ${D}/usr/share/doc/${PF}
		cp doc/*.pdf ${D}/usr/share/doc/${PF}
	fi
}
