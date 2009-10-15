# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ois/ois-1.2.0.ebuild,v 1.2 2009/10/15 06:18:33 mr_bones_ Exp $

EAPI=2
inherit autotools

DESCRIPTION="Object-oriented Input System - A cross-platform C++ input handling library"
HOMEPAGE="http://www.wreckedgames.com/"
SRC_URI="mirror://sourceforge/wgois/${P/-/_}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libXaw
	x11-libs/libX11"

S=${WORKDIR}/${PN}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
