# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jtidy/jtidy-0_pre20010801.ebuild,v 1.3 2004/10/17 09:50:10 dholm Exp $

inherit java-pkg

MY_PV="04aug2000r7"
DESCRIPTION="Tidy is a Java port of HTML Tidy , a HTML syntax checker and pretty printer."
HOMEPAGE="http://jtidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}-dev.zip"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND="virtual/jdk
	>=dev-java/ant-1.5.0"
RDEPEND="virtual/jre"

S=${WORKDIR}/${PN}-${MY_PV}-dev

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/Tidy.jar

	use doc && java-pkg_dohtml -r doc
}
