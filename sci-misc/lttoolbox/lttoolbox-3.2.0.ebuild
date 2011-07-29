# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/lttoolbox/lttoolbox-3.2.0.ebuild,v 1.1 2011/07/29 06:11:09 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Toolbox for lexical processing, morphological analysis and generation of words"
HOMEPAGE="http://apertium.sourceforge.net"
SRC_URI="mirror://sourceforge/apertium/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/libxml2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-flags.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
