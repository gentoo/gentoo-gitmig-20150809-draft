# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcompmgr/xcompmgr-1.1.3-r1.ebuild,v 1.7 2009/05/05 17:43:52 ssuominen Exp $

inherit x-modular

DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://xapps.freedesktop.org/release/${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE=""
RDEPEND="x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXcomposite"
DEPEND="${RDEPEND}"

PATCHES=("${FILESDIR}/fix-unmapped-window-opacity.patch")
