# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcalendar/jcalendar-1.2.2-r1.ebuild,v 1.2 2007/01/10 18:13:37 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java date chooser bean for graphically picking a date."
SRC_URI="http://www.toedter.com/download/${PN}.zip"
HOMEPAGE="http://www.toedter.com/en/jcalendar/"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc"
RDEPEND=">=virtual/jdk-1.4
	=dev-java/jgoodies-looks-1.2*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	rm -f *.jar
	java-pkg_jar-from jgoodies-looks-1.2 looks.jar looks-1.2.2.jar
}

src_compile() {
	cd src/
	eant jar $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar lib/jcalendar.jar

	dodoc readme.txt
	use doc && java-pkg_dohtml -r doc/*
}
