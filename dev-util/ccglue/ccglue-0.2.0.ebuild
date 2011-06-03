# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccglue/ccglue-0.2.0.ebuild,v 1.1 2011/06/03 07:06:38 radhermit Exp $

EAPI=4

inherit eutils

DESCRIPTION="Produce cross-reference files from cscope and ctags for use with app-vim/cctree"
HOMEPAGE="http://ccglue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-release-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/release-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-string.patch
}
