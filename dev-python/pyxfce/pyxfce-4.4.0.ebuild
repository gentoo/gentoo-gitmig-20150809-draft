# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxfce/pyxfce-4.4.0.ebuild,v 1.3 2009/08/15 06:36:38 mr_bones_ Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Python bindings for Xfce4 desktop enviroment"
HOMEPAGE="http://pyxfce.xfce.org"
SRC_URI="${HOMEPAGE}/${P}.tar.gz
	mirror://gentoo/${P}-libxfce4panel-enum-types.h.patch.bz2"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE="debug xfce4panel"

RDEPEND=">=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	xfce4panel? ( >=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION} )
	>=dev-python/pygtk-2.6"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO*"

pkg_setup() {
	XFCE_CONFIG="$(use_enable xfce4panel mighty-mouse)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}/${P}-libxfce4panel-enum-types.h.patch"
}
