# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jms/sun-jms-1.1-r2.ebuild,v 1.2 2006/10/05 15:48:22 gustavoz Exp $

inherit java-pkg-2

At="jms-${PV/./_}-fr-apidocs.zip"
DESCRIPTION="The Java Message Service (JMS) API is a messaging standard that allows application components to create, send, receive, and read messages."
HOMEPAGE="http://java.sun.com/products/jms/"
SRC_URI="${At}"
LICENSE="sun-bcla-jms"
SLOT=0
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"
RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip
	>=virtual/jdk-1.3"
RESTRICT="fetch"

S="${WORKDIR}/${PN//sun-/}${PV}"

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE} and select 'Downloads'"
	einfo " 2. Select 'Download the version 1.1 API Documentation, Jar and Source'"
	einfo " 3. Download ${At}"
	einfo " 4. Move file to ${DISTDIR}"
	einfo
}

src_compile() {
	mkdir build
	cd src/share
	ejavac -nowarn -d ${S}/build $(find -name "*.java") || die "failed too build"
	if use doc ; then
		mkdir ${S}/api
		javadoc -d ${S}/api -quiet javax.jms
	fi

	cd ${S}
	jar cf jms.jar -C build . || die "failed too create jar"
}

src_install() {
	java-pkg_dojar jms.jar
	use doc && java-pkg_dohtml -r api
}

