# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mx4j/mx4j-2.1.0-r1.ebuild,v 1.2 2005/10/24 19:57:10 betelgeuse Exp $

inherit eutils java-pkg

DESCRIPTION="MX4J is a project to build an Open Source implementation of the Java(TM) Management Extensions (JMX) and of the JMX Remote API (JSR 160) specifications, and to build tools relating to JMX."
HOMEPAGE="http://mx4j.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

# The ${S}/BUILD-HOWTO is a good source for dependencies
# This package could also be built with 1.3 after the virtual
# handling for java-config goes official

# javamail and jython support is optional but because ant-core puts it in the classpath
# if it is installed we can't force disable it without modifying the build.xml
# and jikes refuses to compile mx4j with javamail support disabled

# Optional jetty support can be enabled after jetty uses java-pkg_dojar to install jars

RDEPEND=">=virtual/jre-1.4
	=www-servers/axis-1*
	=dev-java/bcel-5.1*
	~dev-java/burlap-3.0.8
	>=dev-java/commons-logging-1.0.4
	~dev-java/hessian-3.0.8
	dev-java/log4j
	=dev-java/servletapi-2.3*
	>=dev-java/sun-jaf-bin-1.0.2
	>=dev-java/sun-javamail-bin-1.3.1
	>=dev-java/jython-2.1"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-1.6
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"

LICENSE="mx4j"
SLOT="2.1"
KEYWORDS="~x86"

IUSE="doc examples jikes source"

src_unpack(){
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib

#	use jetty && java-pkg_jar-from jetty

	# for jmx
	java-pkg_jar-from bcel
	java-pkg_jar-from commons-logging
	java-pkg_jar-from log4j

	# for tools
	java-pkg_jar-from axis-1
	java-pkg_jar-from burlap-3.0
	java-pkg_jar-from hessian-3.0.8
	java-pkg_jar-from servletapi-2.3

	# optionals (tools)
	java-pkg_jar-from jython
	java-pkg_jar-from sun-jaf-bin
	java-pkg_jar-from sun-javamail-bin mail.jar
}

src_compile() {
	cd build/

	# The jsr160 and tools compilation could probably
	# be made optional by use flags.
	local antflags="compile.jmx compile.rjmx compile.tools"
	use doc && antflags="${antflags} javadocs"
	use examples && antflags="${antflags} compile.examples"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_dojar dist/lib/*.jar
	java-pkg_dowar dist/lib/*.war

	dodoc README

	use doc && java-pkg_dohtml -r dist/docs/api/*
	use source && java-pkg_dosrc ${S}/src/core/*

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/examples/mx4j/examples/* ${D}usr/share/doc/${PF}/examples
	fi
}
