# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mindterm/mindterm-3.0.1.ebuild,v 1.1 2006/07/01 16:09:41 nichoj Exp $

inherit eutils java-pkg-2

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/80_MindTerm/"
SRC_URI="http://www.appgate.com/products/80_MindTerm/110_MindTerm_Download/${P/-/_}-src.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc examples"
RDEPEND=">=virtual/jre-1.3"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	dev-java/ant-core"
S=${WORKDIR}/${P/-/_}

src_compile() {
	eant mindterm.jar lite $(use_doc doc)
}

src_install() {
	java-pkg_dojar *.jar

	java-pkg_dolauncher ${PN} --main com.mindbright.application.MindTerm

	dodoc README.txt
	use doc && java-pkg_dojavadoc javadoc

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}

