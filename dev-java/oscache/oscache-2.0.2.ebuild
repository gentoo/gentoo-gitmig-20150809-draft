# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oscache/oscache-2.0.2.ebuild,v 1.4 2005/07/15 18:40:28 axxo Exp $

inherit java-pkg

DESCRIPTION="OSCache is a widely used, high performance J2EE caching framework."
SRC_URI="https://oscache.dev.java.net/files/documents/629/2653/${P}-full.zip"
HOMEPAGE="http://www.opensymphony.com/oscache/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.3
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/servletapi-2.3*
		dev-java/jms
		dev-java/jgroups"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}
		app-arch/unzip
		jikes? ( dev-java/jikes )"
IUSE="doc jikes"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm *.jar
}

src_compile() {
	local javac_cmd="javac"
	use jikes && javac_cmd="jikes -bootclasspath ${JAVA_HOME}/jre/lib/rt.jar"

	local build_dir=${S}/build
	local classpath="-classpath $(java-pkg_getjars commons-logging,commons-collections,servletapi-2.3,jms,jgroups):${build_dir}:."
	mkdir ${build_dir}

	echo "Building core..."
	cd ${S}/src/core/java
	${javac_cmd} ${classpath} -nowarn -d ${build_dir} $(find -name "*.java") || die

	echo "Building cluster support plugin..."
	cd ${S}/src/plugins/clustersupport/java
	find -name "*.java" -exec sed -i -e "s/org.javagroups/org.jgroups/g" {} \;
	${javac_cmd} ${classpath} -nowarn -d ${build_dir} $(find -name "*.java") || die

	echo "Building disk persistence plugin..."
	cd ${S}/src/plugins/diskpersistence/java
	${javac_cmd} ${classpath} -nowarn -d ${build_dir} `find -name "*.java"` || die "compile failed"

	if use doc ; then
		echo "Building documentation..."
		mkdir ${S}/javadoc
		cd ${build_dir}
		local sourcepath="${S}/src/core/java:${S}/src/plugins/diskpersistence/java:${S}/src/plugins/clustersupport/java"
		javadoc ${classpath} -sourcepath ${sourcepath} -d ${S}/javadoc \
			$(find com/opensymphony/oscache -type d | tr '/' '.') \
			|| die "failed to create javadoc"
	fi

	cd ${S}
	jar cf ${PN}.jar -C build .
}

src_install() {
	java-pkg_dojar *.jar
	dodoc readme.txt
	use doc && java-pkg_dohtml -r javadoc
}
