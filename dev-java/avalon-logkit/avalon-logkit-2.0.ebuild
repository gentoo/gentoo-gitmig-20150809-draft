# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-2.0.ebuild,v 1.7 2005/04/03 17:06:33 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Easy-to-use Java logging toolkit"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/avalon-logkit/distributions/${PF}.dev-0-src.tar.gz"
KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc"
LICENSE="Apache-2.0"
SLOT="2.0"
IUSE="doc jikes jms javamail"
DEPEND=">=virtual/jdk-1.4
		jikes? ( >=dev-java/jikes-1.21 )
		>=dev-java/ant-1.5
		dev-java/junit"
RDEPEND=">=virtual/jre-1.4
		dev-java/log4j
		jms? ( || (
			dev-java/jms
			dev-java/openjms
			)
		)
		javamail? ( || (
				dev-java/gnu-javamail
				dev-java/sun-javamail-bin
			)
		)
		=dev-java/servletapi-2.3*"

S=${WORKDIR}/${PF}.dev-0

src_unpack() {
	unpack ${A}
	cd ${S}

	# the build.xml file for ant
	cp ${FILESDIR}/${PV}-build.xml ./build.xml

	# decide which mail implementation we use
	local javamail=""
	if use javamail; then
		if has_version gnu-javamail; then
			javamail="gnu-javamail"
		elif has_version sun-javamail-bin; then
			javamail="sun-javamail-bin"
		fi
	fi

	# decide which jms implementation we use
	local jms=""
	if use jms; then
		if has_version openjms; then
			jms="openjms"
		elif has_version jms; then
			jms="jms"
		fi
	fi

	local libs="log4j,servletapi-2.3"
	use jms && libs="${libs},${jms}"
	use javamail && libs="${libs},${javamail}"

	echo "classpath=`java-config -p ${libs}`" > build.properties

	cd ${S}/src/java/org/apache/log/output/

	if ! use jms; then
		einfo "Removing jms related files"
		rm -rf jms || die "JMS Failure!"
		rm -f ServletOutputLogTarget.java || die "JMS Failure!"
	fi

	if ! use javamail; then
		einfo "Removing javamail related files"
		rm -rf net || die "JavaMail Failure!"
	fi
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Build Failed!"
}

src_install() {
	java-pkg_dojar ${S}/dist/avalon-logkit.jar || die "Install Failed!"

	dodoc README.txt LICENSE.txt
	use doc && java-pkg_dohtml -r ${S}/dist/docs/*
}
