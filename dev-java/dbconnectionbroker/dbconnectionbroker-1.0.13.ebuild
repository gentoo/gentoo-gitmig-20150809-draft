# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dbconnectionbroker/dbconnectionbroker-1.0.13.ebuild,v 1.4 2003/03/27 02:05:36 seemant Exp $

S=${WORKDIR}

DESCRIPTION="JDBC connection pooling and brokering"
HOMEPAGE="http://www.javaexchange.com"
SRC_URI="ftp://www.javaexchange.com/javaexchange/DbConnectionBroker${PV}.tar"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}"

src_compile() {
	jar cf DbConnectionBroker.jar com || die "jar problem"
}

src_install() {
	dojar DbConnectionBroker.jar
	dohtml -r doc/*
}
