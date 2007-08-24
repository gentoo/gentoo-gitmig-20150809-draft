# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfkc/xfkc-0.2.ebuild,v 1.2 2007/08/24 13:41:02 angelos Exp $

inherit xfce44

xfce44

DESCRIPTION="a keyboard layout configuration tool"
HOMEPAGE="http://gauvain.tuxfamily.org/code/xfkc.html"
SRC_URI="http://gauvain.tuxfamily.org/code/archive/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="debug nls"

RDEPEND=">=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=x11-libs/libxklavier-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool sys-devel/gettext )"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable nls)"

DOCS="AUTHORS ChangeLog NEWS README TODO"
