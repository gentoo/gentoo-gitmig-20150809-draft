# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/edtftpj/edtftpj-1.5.3-r1.ebuild,v 1.1 2007/01/26 15:22:02 wltjr Exp $

inherit java-pkg-2

DESCRIPTION="FTP client library written in Java"
SRC_URI="http://www.enterprisedt.com/products/edtftpj/download/${P}.zip"
HOMEPAGE="http://www.enterprisedt.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples source"

RDEPEND=">=virtual/jre-1.4
		dev-java/junit"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	${RDEPEND}
	source? ( app-arch/zip )"

src_unpack() {
	unpack "${A}"
	find "${S}" -name "*.jar" | xargs rm -fr
	rm "${S}/doc/LICENSE.TXT" || die "Failed to remove LICENSE.TXT"
}

src_compile() {
	cd ${S}/src
	local antflags="jar -Dftp.classpath=$(java-pkg_getjars junit)"
	eant ${antflags} $(use_doc javadocs)

}

src_install() {
	use doc && java-pkg_dohtml -r build/doc/api
	use source && java-pkg_dosrc src/com

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/*.{java,txt} || die "Failed to install examples."
	fi

	dodoc doc/*.TXT doc/*.pdf

	java-pkg_dojar lib/*.jar
}
