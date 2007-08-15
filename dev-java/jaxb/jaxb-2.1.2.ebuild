# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxb/jaxb-2.1.2.ebuild,v 1.3 2007/08/15 11:00:48 opfer Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Reference implementation of the JAXB specification."
HOMEPAGE="http://jaxb.dev.java.net/"
DATE="20070125"
MY_P="JAXB2_src_${DATE}"
SRC_URI="https://jaxb.dev.java.net/${PV}/${MY_P}.jar"

LICENSE="CDDL"
SLOT="2"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/iso-relax
	dev-java/istack-commons-runtime
	dev-java/jsr173
	dev-java/msv
	dev-java/relaxng-datatype
	dev-java/rngom
	dev-java/sun-jaf
	dev-java/txw2-runtime
	dev-java/xml-commons-resolver
	dev-java/xsdlib
	dev-java/xsom"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/jaxb-ri-${DATE}"

src_unpack() {
	echo "A" | java -jar "${DISTDIR}/${A}" -console > /dev/null || die "unpack failed"

	# Source is missing Messages.properties, copy it from binary version:
	cd "${T}"
	unzip -qq "${S}/lib/jaxb-api.jar"
	for mp in $(find javax -name '*.properties'); do
		mv "${mp}" "${S}/src/${mp}" || die
	done

	cd "${S}/lib"
	rm -v *.jar || die

	java-pkg_jarfrom --build-only ant-core
	java-pkg_jarfrom iso-relax
	java-pkg_jarfrom istack-commons-runtime
	java-pkg_jarfrom jsr173
	java-pkg_jarfrom msv
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom rngom
	java-pkg_jarfrom sun-jaf
	java-pkg_jarfrom txw2-runtime
	java-pkg_jarfrom xml-commons-resolver
	java-pkg_jarfrom xsdlib
	java-pkg_jarfrom xsom
	ln -s $(java-config --tools) || die

	cd "${S}/src/com/sun/"
	rm -rf codemodel # in dev-java/codemodel
	rm -rf tools # in dev-java/jaxb-tools

	cp -v "${FILESDIR}/build.xml-${PV}" "${S}/build.xml" || die "cp failed"

}

src_install() {

	java-pkg_dojar jaxb-api.jar
	java-pkg_dojar jaxb-impl.jar

	use source && java-pkg_dosrc src/*

}
