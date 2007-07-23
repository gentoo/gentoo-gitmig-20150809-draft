# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-2.0.4-r2.ebuild,v 1.3 2007/07/23 16:05:15 nixnut Exp $

inherit eutils java-pkg-2 java-ant-2

MY_V="${PV//./_}"
DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${MY_V}.zip"

LICENSE="BSD"
SLOT="2.0"
KEYWORDS="amd64 ppc ~x86"
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

	# unzip the look&feel settings from bundled jar before we delete it
	unzip -j looks-${PV}.jar META-INF/services/javax.swing.LookAndFeel \
		|| die "unzip of javax.swing.LookAndFeel failed"
	# and rename it to what build.xml expects
	mv javax.swing.LookAndFeel all.txt

	rm -v *.jar demo/*.jar lib/*.jar
	rm -rf docs/api
}

src_compile() {
	# bug #150970
	java-pkg_filter-compiler jikes

	# jar target fails unless we make descriptors.dir an existing directory
	# I checked the ustream binary distribution and they also don't actually
	# put anything there.
	# 31.7.2006 betelgeuse@gentoo.org
	# update: it's where it looks for all.txt file
	# 16.1.2007 caster@gentoo.org
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
