# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/servletapi/servletapi-2.2-r1.ebuild,v 1.6 2005/03/23 12:09:11 axxo Exp $

inherit java-pkg

S=${WORKDIR}/jakarta-servletapi-src
DESCRIPTION="Servlet API ${PV} from jakarta.apache.org"
HOMEPAGE="http://jakarta.apache.org/"
SRC_URI="mirror://gentoo/${PN}-${PV}-20021101.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="2.2"
KEYWORDS="x86 ~sparc ~ppc amd64"
IUSE="jikes doc"

src_compile() {
	local myc

	if use jikes ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi
	cd ${S}
	ANT_OPTS=${myc} ant all
}

src_install () {
	cd ..
	cd  dist
	mv servletapi/lib/servlet.jar servletapi/lib/${PN}-${PV}.jar
	java-pkg_dojar servletapi/lib/${PN}-${PV}.jar || die "Unable to install"

	if use doc ; then
		java-pkg_dohtml -r servletapi/docs/*
	fi

	dodoc dist/README.txt
}
