# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix/cryptix-3.2.0-r1.ebuild,v 1.2 2007/03/17 20:45:05 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Aims at facilitating the task programmers face in coding, accessing and generating java-bound, both types and values, defined as ASN.1 constructs, or encoded as such."
HOMEPAGE="http://cryptix-asn1.sourceforge.net/"
SRC_URI="mirror://gentoo/cryptix32-20001002-r${PV}.zip"

LICENSE="CGL"
SLOT="3.2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp -i "${FILESDIR}/build.xml" . || die
	rm -v cryptix32.jar || die
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar lib/cryptix32.jar

	use doc && java-pkg_dojavadoc doc/api
	use source && java-pkg_dosrc src/*
}
