# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/springgraph/springgraph-82.ebuild,v 1.9 2004/10/19 10:33:21 absinthe Exp $

inherit eutils

DESCRIPTION="Generate spring graphs from graphviz input files"
HOMEPAGE="http://www.chaosreigns.com/code/springgraph"
MY_PV="0.${PV}"
MY_P="${PN}_${MY_PV}"
SRC_FILE="${MY_P}.orig.tar.gz"
SRC_DEBIAN_PATCH="${MY_P}-1.diff.gz"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${SRC_FILE}
		 mirror://debian/pool/main/${PN:0:1}/${PN}/${SRC_DEBIAN_PATCH}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha hppa ~mips ppc sparc ~ia64 amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-perl/GD"
S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${SRC_FILE}
	epatch ${DISTDIR}/${SRC_DEBIAN_PATCH}
}

src_compile() {
	# nothing to do
	:
}

src_install() {
	into /usr
	dobin ${PN}
	doman debian/${PN}.1
}
