# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr311-api/jsr311-api-1.0.ebuild,v 1.3 2009/03/31 17:33:10 betelgeuse Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JAX-RS: Java API for RESTful Web Services"
HOMEPAGE="https://jsr311.dev.java.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
		test? ( dev-java/ant-junit:0 dev-java/junit:0 )"
RDEPEND=">=virtual/jre-1.5"

# Helper to generate the tarball :-)
# ( PN=jsr311-api ; P=jsr311-api-1.0 ; . jsr311-api-1.0.ebuild  ; src_tarball )
src_tarball() {
	svn export \
		--username guest --password '' --non-interactive \
		${HOMEPAGE}/svn/jsr311/tags/${P}/${PN} ${P} \
		&& \
	tar cvjf ${P}.tar.bz2 ${P} \
		&& \
	echo "New tarball located at ${P}.tar.bz2"
}

java_prepare() {
	for i in build.xml maven-build.xml manifest ; do
		cp -f "${FILESDIR}"/"${P}-${i}" "${i}" \
			|| die "Unable to find ${P}-${i}"
	done
}

src_install() {
	dodoc README.txt || die
	java-pkg_newjar target/${P}.jar jsr311-api.jar
	use doc	&& java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/javax
}

src_test() {
	EANT_GENTOO_CLASSPATH="junit ant-core" \
	ANT_TASKS="ant-junit" \
	eant test
}
