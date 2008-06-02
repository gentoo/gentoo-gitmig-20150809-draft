# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/sisc/sisc-1.16.6.ebuild,v 1.3 2008/06/02 22:11:26 pchrist Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="An extensible Java based interpreter of the algorithmic \
language Scheme."
HOMEPAGE="http://sisc-scheme.org/"
SRC_URI="mirror://sourceforge/sisc/${P}.jar"
LICENSE="|| ( GPL-2 MPL-1.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"
S=${S%-${PVR}}

src_unpack() {
	jar -xf "${DISTDIR}/${A}"
}

src_compile() {
	eant clean || die "Cleaning with ant failed."
	eant all || die "building all target with ant, failed."
}

src_install() {
	local h_path="/usr/share/${PN}"
	java-pkg_newjar ${PN}.jar ${PN}.jar
	java-pkg_newjar ${PN}-heap.jar ${PN}-heap.jar
	java-pkg_newjar ${PN}-lib.jar ${PN}-lib.jar
	java-pkg_newjar ${PN}-opt.jar ${PN}-opt.jar
	insinto "${h_path}"
	doins sisc.shp
	java-pkg_dolauncher "sisc" --main "sisc.REPL -h ${h_path}/sisc.shp"
}
