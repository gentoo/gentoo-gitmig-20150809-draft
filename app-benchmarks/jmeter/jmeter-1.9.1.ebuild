# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-1.9.1.ebuild,v 1.4 2004/10/12 19:35:23 axxo Exp $

DESCRIPTION="Load test and measure performance on HTTP/FTP services, and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter/index.html"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}.src.tgz"
DEPEND=">=virtual/jdk-1.3
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="doc jikes"

S=${WORKDIR}/jakarta-${P}

src_compile () {
	local antflags="package"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} alldocs"
	ant ${antflags}
}

src_install () {
	# Can't think of a better way to deal with this for now...
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -ar bin/ lib/ ${D}/opt/${PN}/
	dodoc README
	use doc && dohtml -r docs/*
}
