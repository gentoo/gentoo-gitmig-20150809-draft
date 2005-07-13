# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-im-exporter/xml-im-exporter-1.1.ebuild,v 1.3 2005/07/13 12:06:46 axxo Exp $

inherit java-pkg

DESCRIPTION="XML Im-/Exporter is a low level library to assist you in the straight forward process of importing and exporting XML from and to your Java classes."
HOMEPAGE="http://xml-im-exporter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_newjar lib/${PN}${PV}.jar ${PN}.jar

	dodoc Changes.txt Open-Issues.txt Readme.txt Version.txt
	use doc && java-pkg_dohtml -r doc
	use source && java-pkg_dosrc src/main/*
}
