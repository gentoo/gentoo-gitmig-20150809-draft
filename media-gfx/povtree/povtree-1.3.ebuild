# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povtree/povtree-1.3.ebuild,v 1.1 2003/11/03 23:56:54 mr_bones_ Exp $

S="${WORKDIR}"
DESCRIPTION="Tree generator for POVray based on TOMTREE macro"
HOMEPAGE="http://propro.ru/go/Wshop/tools/tools.html"
SRC_URI="http://propro.ru/go/Wshop/tools/files/${PN}${PV}.zip"

KEYWORDS="~x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/jre-1.3
	virtual/x11"
DEPEND="app-arch/unzip"

src_install() {
	dobin ${FILESDIR}/povtree              || die "dobin failed"
	insinto /usr/lib/povtree
	doins povtree.jar                      || die "doins failed"
	dodoc README.txt TOMTREEm.inc help.jpg || die "dodoc failed"
}
