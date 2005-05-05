# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/edtftpj/edtftpj-1.4.8.ebuild,v 1.1 2005/05/05 13:38:05 luckyduck Exp $

inherit java-pkg

DESCRIPTION="FTP client library written in Java"
SRC_URI="http://www.enterprisedt.com/products/edtftpj/download/${P}.tar.gz"
HOMEPAGE="http://www.enterprisedt.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="jikes doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	cd ${S}/src
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	cd ${S}
	use doc && java-pkg_dohtml -r build/doc/api
	dodoc doc/*.TXT
	insinto /usr/share/doc/${PF}
	doins doc/*.pdf

	mv ${S}/build/${P}.jar ${S}/build/${PN}.jar
	java-pkg_dojar build/${PN}.jar
}
