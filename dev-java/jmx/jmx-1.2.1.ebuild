# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmx/jmx-1.2.1.ebuild,v 1.8 2004/11/03 11:31:43 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Management Extensions for managing and monitoring devices, applications, and services."
HOMEPAGE="http://java.sun.com/products/JavaManagement/index.jsp"
SRC_URI="${PN}-${PV//./_}-scsl.zip"
LICENSE="sun-csl"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		sys-apps/sed"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="fetch"

S="${WORKDIR}/${P//./_}-src"

DOWNLOADSITE="http://wwws.sun.com/software/communitysource/jmx/download.html"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i.orig -r -e 's/="src"/="src\/jmxri"/g' build.xml
}
pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo " "
	einfo " 1. Visit ${DOWNLOADSITE} and follow instructions"
	einfo " 2. Download ${SRC_URI}"
	einfo " 3. Move file to ${DISTDIR}"
	einfo " 4. Run emerge on this package again to complete"
	einfo
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} examples"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar lib/*.jar
	use doc && java-pkg_dohtml -r docs/*
	use doc && dohtml -f examples/*
}
