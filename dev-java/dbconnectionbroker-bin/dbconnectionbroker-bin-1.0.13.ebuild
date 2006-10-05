# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dbconnectionbroker-bin/dbconnectionbroker-bin-1.0.13.ebuild,v 1.7 2006/10/05 15:36:22 gustavoz Exp $

inherit java-pkg

DESCRIPTION="JDBC connection pooling and brokering"
HOMEPAGE="http://www.javaexchange.com"
SRC_URI="ftp://www.javaexchange.com/javaexchange/DbConnectionBroker${PV}.tar"
IUSE="doc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc amd64"
RDEPEND=">=virtual/jre-1.2"
DEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}

src_compile() {
	jar cf DbConnectionBroker.jar com || die "jar problem"
}

src_install() {
	java-pkg_dojar DbConnectionBroker.jar
	use doc && java-pkg_dohtml -r doc/*
}
