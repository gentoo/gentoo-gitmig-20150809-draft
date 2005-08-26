# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-2.0.1.ebuild,v 1.7 2005/08/26 12:31:45 flameeyes Exp $

inherit java-pkg

DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}_src.tgz"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant
	doc? ( >=dev-java/velocity-1.4 )"
	# jikes ( dev-java/jikes"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc" # jikes"

S=${WORKDIR}/jakarta-${P}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	use doc && java-pkg_jarfrom velocity
}

src_compile() {
	local antflags="package"
	#Does not compile with jikes, patches welcome at bugs.gentoo.org
	#use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs-all"
	ant ${antflags} || die "compile problem"
}

src_install() {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -pPR bin/ lib/ printable_docs/ ${D}/opt/${PN}/
	dodoc README
	use doc && java-pkg_dohtml -r docs/*
}
