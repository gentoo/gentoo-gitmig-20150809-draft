# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxfce/pyxfce-4.4.0.ebuild,v 1.1 2007/02/07 10:35:50 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="Python bindings for Xfce4 desktop enviroment"
HOMEPAGE="http://pyxfce.xfce.org"
SRC_URI="$HOMEPAGE/$P.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=dev-python/pygtk-2.6"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO*"
