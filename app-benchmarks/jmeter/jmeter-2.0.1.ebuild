# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-2.0.1.ebuild,v 1.2 2004/10/12 19:35:23 axxo Exp $

DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}_src.tgz"
DEPEND=">=virtual/jdk-1.3
	doc? ( >=dev-java/velocity-1.4 )"
	# jikes ( dev-java/jikes"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc" # jikes"

S=${WORKDIR}/jakarta-${P}

src_compile () {
	local antflags="package"
	#Does not compile with jikes, patches welcome at bugs.gentoo.org
	#use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs-all"
	use doc && cp /usr/share/velocity/lib/velocity-*.jar $S/lib
	ant ${antflags} || die "compile problem"
}

src_install () {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -ar bin/ lib/ printable_docs/ ${D}/opt/${PN}/
	dodoc README
	use doc && dohtml -r docs/*
}
