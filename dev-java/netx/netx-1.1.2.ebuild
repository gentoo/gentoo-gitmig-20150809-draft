# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netx/netx-1.1.2.ebuild,v 1.1 2011/09/08 11:22:15 fordfrog Exp $

EAPI="4"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2

DESCRIPTION="IcedTea JNLP implementation"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="http://icedtea.classpath.org/download/source/icedtea-web-${PV}.tar.gz"

LICENSE="GPL-2 GPL-2-with-linking-exception LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="source"

CDEPEND="dev-java/rhino:1.6"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}/icedtea-web-${PV}/"

src_configure() {
	econf --with-rhino $(java-pkg_getjar rhino-1.6 js.jar)  || die
}

src_compile() {
	emake netx-dist || die
}

src_install() {
	java-pkg_newjar "${S}"/netx.build/lib/classes.jar ${PN}.jar
	use source && java-pkg_dosrc netx/*
}
