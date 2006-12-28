# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxfce/pyxfce-4.3.91.ebuild,v 1.1 2006/12/28 02:32:44 nichoj Exp $

inherit xfce44

DESCRIPTION="Xfce4 python bindings"
HOMEPAGE="http://pyxfce.xfce.org"
SRC_URI="$HOMEPAGE/$P.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"

DEPEND=">=xfce-base/libxfcegui4-4.3.90
	xfce-base/xfce-mcs-manager
	>=dev-python/pygtk-2.6"
