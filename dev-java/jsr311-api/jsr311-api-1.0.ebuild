# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr311-api/jsr311-api-1.0.ebuild,v 1.1 2009/02/23 10:37:45 robbat2 Exp $

JAVA_PKG_IUSE="doc source"
JAVA_PKG_STRICT=1

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="JAX-RS: Java API for RESTful Web Services"
HOMEPAGE="https://jsr311.dev.java.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
		test? ( dev-java/ant-junit =dev-java/junit-3* )"
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	for i in build.xml maven-build.xml manifest ; do
		cp -f "${FILESDIR}"/"${P}-${i}" "${i}" \
			|| die "Unable to find ${P}-${i}"
	done
	cd "${S}"/lib
	java-pkg_jar-from --build-only junit
}

src_install() {
	dodoc README.txt
	java-pkg_newjar target/${P}.jar jsr311-api.jar
	use doc \
		&& java-pkg_dojavadoc target/site/apidocs/ \
		|| die "Failed javadoc"
	use source \
		&& java-pkg_dosrc src/javax/*
}

src_test() {
	EANT_GENTOO_CLASSPATH="junit ant-core" \
	ANT_TASKS="ant-junit" \
	eant test
}
