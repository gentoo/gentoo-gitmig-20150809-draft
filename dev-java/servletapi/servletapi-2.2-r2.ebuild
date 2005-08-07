# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/servletapi/servletapi-2.2-r2.ebuild,v 1.2 2005/08/07 13:42:50 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="Servlet API ${PV} from jakarta.apache.org"
HOMEPAGE="http://jakarta.apache.org/"
SRC_URI="mirror://gentoo/${P}-20021101.tar.gz"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="2.2"
KEYWORDS="x86 ~sparc ~ppc amd64"
IUSE="jikes doc"
S=${WORKDIR}/jakarta-servletapi-src

src_compile() {
	local antflags="all"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	cd ../dist
	java-pkg_dojar servletapi/lib/servlet.jar || die "Unable to install"

	use doc && java-pkg_dohtml -r servletapi/docs/*

	dodoc dist/README.txt
}
