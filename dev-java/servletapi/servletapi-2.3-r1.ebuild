# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/servletapi/servletapi-2.3-r1.ebuild,v 1.9 2005/04/03 02:29:35 weeve Exp $

inherit java-pkg

S=${WORKDIR}/jakarta-servletapi-4
DESCRIPTION="Servlet API ${PV} from jakarta.apache.org"
HOMEPAGE="http://jakarta.apache.org/"
SRC_URI="mirror://gentoo/${PN}-${PV}-20021101.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="x86 sparc ~ppc amd64 ppc64"
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
	mv dist/lib/servlet.jar dist/lib/${PN}-${PV}.jar
	java-pkg_dojar dist/lib/${PN}-${PV}.jar || die "Unable to install"

	if use doc ; then
		java-pkg_dohtml -r dist/docs/*
	fi

	dodoc dist/README.txt
}
