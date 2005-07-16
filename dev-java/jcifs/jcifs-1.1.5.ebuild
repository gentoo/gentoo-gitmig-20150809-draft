# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcifs/jcifs-1.1.5.ebuild,v 1.4 2005/07/16 10:23:25 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Library that implements the CIFS/SMB networking protocol in Java"
SRC_URI="http://jcifs.samba.org/src/${P}.tgz"
HOMEPAGE="http://jcifs.samba.org/"
LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.4
	=dev-java/servletapi-2.3*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4"

S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/build-xml.patch
	java-pkg_jar-from servletapi-2.3
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api docs/*.html
}
