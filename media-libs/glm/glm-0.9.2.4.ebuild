# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glm/glm-0.9.2.4.ebuild,v 1.1 2011/09/14 07:44:21 tupone Exp $

EAPI=3

DESCRIPTION="OpenGL Mathematics"
HOMEPAGE="http://glm.g-truc.net/"
SRC_URI="mirror://sourceforge/ogl-math/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodoc doc/glm-0.9.2.pdf
	cd ${PN}
	insinto /usr/include/${PN}
	doins -r *.hpp core gtc gtx virtrev || die "Install failed"
	rm "${D}"/usr/include/${PN}/core/*cpp
}
