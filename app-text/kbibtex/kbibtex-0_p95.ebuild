# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbibtex/kbibtex-0_p95.ebuild,v 1.3 2009/11/08 14:06:59 ssuominen Exp $

EAPI=2
WEBKIT_REQUIRED=always
inherit eutils kde4-base

DESCRIPTION="A BibTeX editor for KDE"
HOMEPAGE="http://home.gna.org/kbibtex/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2
	http://dev.gentoo.org/~ssuominen/kbibtex.png.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="!${CATEGORY}/${PN}:0"
RDEPEND="${DEPEND}
	virtual/tex-base"

PATCHES=( "${FILESDIR}/${P}-entry.patch" )

src_install() {
	kde4-base_src_install
	doicon "${WORKDIR}"/${PN}.png
}
