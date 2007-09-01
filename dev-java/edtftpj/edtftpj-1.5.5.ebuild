# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/edtftpj/edtftpj-1.5.5.ebuild,v 1.2 2007/09/01 17:07:14 nixnut Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="FTP client library written in Java"
SRC_URI="http://www.enterprisedt.com/products/edtftpj/download/${P}.zip"
HOMEPAGE="http://www.enterprisedt.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"

RDEPEND=">=virtual/jre-1.4
	dev-java/junit"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${RDEPEND}"

src_unpack() {
	unpack "${A}"
	find "${S}" -name "*.jar" | xargs rm -fr
	rm "${S}/doc/LICENSE.TXT" || die "Failed to remove LICENSE.TXT"
}

src_compile() {
	cd ${S}/src
	eant jar -Dftp.classpath=$(java-pkg_getjars junit) $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar lib/*.jar

	use doc && java-pkg_dojavadoc build/doc/api
	use source && java-pkg_dosrc src/com

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/*.{java,txt} || die "Failed to install examples."
	fi

	dodoc doc/*.TXT doc/*.pdf || die
}
