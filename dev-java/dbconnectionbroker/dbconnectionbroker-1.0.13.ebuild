# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dbconnectionbroker/dbconnectionbroker-1.0.13.ebuild,v 1.7 2004/03/22 23:08:38 zx Exp $

inherit java-pkg

DESCRIPTION="JDBC connection pooling and brokering"
HOMEPAGE="http://www.javaexchange.com"
SRC_URI="ftp://www.javaexchange.com/javaexchange/DbConnectionBroker${PV}.tar"
IUSE="doc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"
RDEPEND=">=virtual/jdk-1.2"
DEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}

src_compile() {
	jar cf DbConnectionBroker.jar com || die "jar problem"
}

src_install() {
	java-pkg_dojar DbConnectionBroker.jar
	use doc && dohtml -r doc/*
}
