# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netx/netx-1.1.2.ebuild,v 1.2 2011/09/09 09:16:56 caster Exp $

EAPI="4"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="Open-source JNLP implementation, icedtea-web fork"
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

JAVA_GENTOO_CLASSPATH="rhino-1.6"
JAVA_SRC_DIR="netx"

# we don't use the icedtea-web buildsystem because it relies on icedtea for the parts we don't need here
src_configure() {
	:;
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use source && java-pkg_dosrc netx/*
}
