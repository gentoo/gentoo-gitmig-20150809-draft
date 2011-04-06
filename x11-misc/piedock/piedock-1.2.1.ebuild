# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/piedock/piedock-1.2.1.ebuild,v 1.1 2011/04/06 11:00:24 hwoarang Exp $

EAPI=2
inherit base

MY_PN=PieDock
MY_P=${MY_PN}-${PV}

DESCRIPTION="A little bit like the famous OS X dock but in shape of a pie menu"
HOMEPAGE="http://markusfisch.de/PieDock"
SRC_URI="http://markusfisch.de/downloads/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	x11-libs/libX11
	x11-libs/libXft
	media-libs/freetype:2"

S=${WORKDIR}/${MY_P}

DOCS=(
	res/${MY_PN}rc.sample
)

src_configure() {
	econf --bindir="${EPREFIX}"/usr/bin
}
