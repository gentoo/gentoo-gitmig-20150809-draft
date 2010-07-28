# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bdsup2sub/bdsup2sub-4.0.0.ebuild,v 1.1 2010/07/28 21:59:12 sbriesen Exp $

EAPI="2"

ESVN_REPO_URI="http://javaforge.com/svn/bdsup2sub/tags/${PV}/"
ESVN_USER="anonymous"
ESVN_PASSWORD="anon"

JAVA_PKG_IUSE="doc source"

inherit eutils subversion java-pkg-2 java-ant-2

DESCRIPTION="A tool to convert and tweak bitmap based subtitle streams"
HOMEPAGE="http://bdsup2sub.javaforge.com/help.htm"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

java_prepare() {
	# Use XDG spec for INI file
	epatch "${FILESDIR}//${P}-xdg.diff"

	# copy build.xml
	cp -f "${FILESDIR}/build-${PV}.xml" build.xml || die
}

src_compile() {
	eant build $(use_doc)
}

src_install() {
	java-pkg_dojar dist/BDSup2Sub.jar
	java-pkg_dolauncher BDSup2Sub --main BDSup2Sub --java_args -Xmx256m
	newicon bin_copy/icon_32.png BDSup2Sub.png
	make_desktop_entry BDSup2Sub BDSup2Sub BDSup2Sub
	use doc && java-pkg_dojavadoc apidocs
	use source && java-pkg_dosrc src
}
