# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mojarra/mojarra-1.2.14.ebuild,v 1.1 2010/02/23 22:01:02 nelchael Exp $

EAPI=3

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_PV="$(get_version_component_range 1-2)_$(get_version_component_range 3)"

DESCRIPTION="Project Mojarra - GlassFish's Implementation for JavaServer Faces API"
HOMEPAGE="https://javaserverfaces.dev.java.net/"
SRC_URI="https://javaserverfaces.dev.java.net/files/documents/1866/146227/${PN}-${MY_PV}-source.zip
	mirror://gentoo/${PN}-${MY_PV}-gentoo.patch.bz2"

LICENSE="CDDL"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	dev-java/ant-contrib
	dev-java/commons-beanutils:1.6
	dev-java/commons-collections
	dev-java/commons-digester
	dev-java/commons-logging
	dev-java/glassfish-servlet-api:2.5
	dev-java/jakarta-jstl
	${COMMON_DEP}"

S="${WORKDIR}/${PN}-${MY_PV}-b01-FCS-sources"

src_prepare() {
	epatch "${DISTDIR}/${PN}-${MY_PV}-gentoo.patch.bz2"

	mkdir -p "${S}/dependencies/jars" || die

	find -name '*.jar' -exec rm -f {} \;

	cd "${S}/common/lib/"
	java-pkg_jarfrom --build-only ant-contrib

	cd "${S}/dependencies/jars"
	java-pkg_jarfrom --build-only commons-digester
	java-pkg_jarfrom --build-only commons-logging
	java-pkg_jarfrom --build-only commons-collections
	java-pkg_jarfrom --build-only commons-beanutils-1.6
	java-pkg_jarfrom --build-only glassfish-servlet-api-2.5
	java-pkg_jarfrom --build-only jakarta-jstl
}

src_compile() {
	cd "${S}/jsf-api"
	eant -Djsf.build.home="${S}" -Dcontainer.name=glassfish jars
}

src_install() {
	java-pkg_dojar "${S}/jsf-api/build/lib/jsf-api.jar"
	use source && java-pkg_dosrc "${S}"/jsf-api/src/*
}
