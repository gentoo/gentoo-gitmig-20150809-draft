# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatar/javatar-2.5-r1.ebuild,v 1.2 2006/12/11 01:47:30 caster Exp $

inherit java-pkg-2 eutils

DESCRIPTION="Java library for creation and extraction of tar archives"
HOMEPAGE="http://www.trustice.com/java/tar/"
SRC_URI="ftp://ftp.gjt.org/pub/time/java/tar/${P}.tar.gz"

LICENSE="public-domain"
SLOT="2.5"
IUSE="doc source"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/sun-jaf"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )
	${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}/javatar-2.5-build.xml" build.xml || die "cp build.xml failed"

	rm -rf jars
	mkdir lib && cd lib
	java-pkg_jar-from sun-jaf
}

src_compile() {
	eant jar $(use_doc docs)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	java-pkg_dolauncher ${PN} --main com.ice.tar.tar

	dodoc doc/LICENSE
	dohtml doc/*.html

	use doc && java-pkg_dojavadoc docs

	use source && java-pkg_dosrc source/com
}
