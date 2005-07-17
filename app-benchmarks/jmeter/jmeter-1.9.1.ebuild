# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-1.9.1.ebuild,v 1.8 2005/07/17 11:14:12 axxo Exp $

inherit java-pkg

DESCRIPTION="Load test and measure performance on HTTP/FTP services, and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter/index.html"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}.src.tgz"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="doc jikes"

S=${WORKDIR}/jakarta-${P}

src_compile () {
	local antflags="package"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} alldocs"
	ant ${antflags} || die "build failed"
}

src_install() {
	# Can't think of a better way to deal with this for now...
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -ar bin/ lib/ ${D}/opt/${PN}/ || die "failed to install"
	dodoc README
	use doc && java-pkg_dohtml -r docs/*
}
