# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-2.0.4-r1.ebuild,v 1.3 2006/12/07 07:36:06 opfer Exp $

inherit eutils java-pkg-2 java-ant-2

MY_V=${PV//./_}
DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${MY_V}.zip"

LICENSE="BSD"
SLOT="2.0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/looks-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove the bootclasspath brokedness, make building demo optional
	epatch "${FILESDIR}/${P}-build.xml.patch"

	rm -v *.jar demo/*.jar lib/*.jar
	rm -rf docs/api
}

src_compile() {
	# bug #150970
	java-pkg_filter-compiler jikes ecj-3.1

	# jar target fails unless we make descriptors.dir an existing directory
	# I checked the ustream binary distribution and they also don't actually
	# put anything there.
	# 31.7.2006 betelgeuse@gentoo.org
	eant -Ddescriptors.dir="${S}" jar-all $(use_doc)
}

src_install() {
	java-pkg_dojar build/looks.jar

	dodoc RELEASE-NOTES.txt
	dohtml README.html
	if use doc; then
		java-pkg_dohtml -r docs/*
		java-pkg_dojavadoc build/docs/api
	fi
	use source && java-pkg_dosrc src/core/com
}
