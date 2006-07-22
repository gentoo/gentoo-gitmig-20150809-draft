# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-2.0.1-r1.ebuild,v 1.12 2006/07/22 22:23:50 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}_src.tgz"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant
	doc? ( >=dev-java/velocity-1.4 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S=${WORKDIR}/jakarta-${P}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	use doc && java-pkg_jarfrom velocity
}

src_compile() {
	local antflags="package"
	use doc && antflags="${antflags} docs-all"
	eant ${antflags} || die "compile problem"
}

src_install() {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -pPR bin/ lib/ printable_docs/ ${D}/opt/${PN}/
	dodoc README
	use doc && java-pkg_dohtml -r docs/*
}
