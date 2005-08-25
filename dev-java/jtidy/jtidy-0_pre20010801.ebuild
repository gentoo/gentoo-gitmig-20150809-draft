# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jtidy/jtidy-0_pre20010801.ebuild,v 1.7 2005/08/25 03:12:02 agriffis Exp $

inherit eutils java-pkg

MY_PV="04aug2000r7"
DESCRIPTION="Tidy is a Java port of HTML Tidy , a HTML syntax checker and pretty printer."
HOMEPAGE="http://jtidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}-dev.zip"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}-${MY_PV}-dev

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/jtidy-source-1.4.patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/Tidy.jar

	use doc && java-pkg_dohtml -r doc
}
