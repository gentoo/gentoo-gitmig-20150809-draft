# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jimi/jimi-1.0.ebuild,v 1.9 2005/07/16 09:39:55 axxo Exp $

inherit java-pkg

# WARNING!!
#
# This ebuild has been deprecated. All new development should happen on dev-java/sun-jimi-bin
#
# -- karltk

DESCRIPTION="Jimi is a class library for managing images."
HOMEPAGE="http://java.sun.com/products/jimi/"
SRC_URI="jimi1_0.zip"
LICENSE="sun-bcla-jimi"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.2
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.2"
RESTRICT="fetch"

S=${WORKDIR}/Jimi

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7259-jimi_sdk-1.0-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${A} from the following url and place it in ${DISTDIR}"
	einfo "${DOWNLOAD_URL} "
}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf src/classes/*
}

src_compile() {
	cd ${S}/src
	javac -source 1.2 -target 1.2 -classpath . -d classes $(cat main_classes.txt) || die "failes to	compile"
	jar -cf ${PN}.jar -C classes . || die "failed to create jar"
}

src_install() {
	java-pkg_dojar src/${PN}.jar

	dodoc Readme License
	use doc && java-pkg_dohtml -r docs/*
}
