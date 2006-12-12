# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-2.0-r2.ebuild,v 1.2 2006/12/12 06:13:30 opfer Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Easy-to-use Java logging toolkit"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/avalon-logkit/distributions/${P}.dev-0-src.tar.gz"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86"
LICENSE="Apache-2.0"
SLOT="2.0"
IUSE="doc javamail jms source"
COMMON_DEP="
	dev-java/log4j
	jms? ( dev-java/sun-jms )
	javamail? (
		dev-java/sun-jaf
		dev-java/sun-javamail
	)
	=dev-java/servletapi-2.4*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.3*
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	source? ( app-arch/zip )
	dev-java/ant-core
	${COMMON_DEP}"

S="${WORKDIR}/${P}.dev-0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# the build.xml file for ant
	cp ${FILESDIR}/${PV}-build.xml ./build.xml

	local libs="log4j,servletapi-2.4"
	use jms && libs="${libs},sun-jms"
	use javamail && libs="${libs},sun-jaf,sun-javamail"

	echo "classpath=$(java-pkg_getjars ${libs})" > build.properties

	cd "${S}/src/java/org/apache/log/output/"

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
	eant $(use_doc) jar
}

src_install() {
	java-pkg_dojar ${S}/dist/avalon-logkit.jar || die "Install Failed!"

	dodoc README.txt LICENSE.txt
	use doc && java-pkg_dohtml -r ${S}/dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
