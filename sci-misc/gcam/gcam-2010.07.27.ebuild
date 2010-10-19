# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gcam/gcam-2010.07.27.ebuild,v 1.2 2010/10/19 09:46:02 hwoarang Exp $

EAPI="1"

inherit base

DESCRIPTION="GNU Computer Aided Manufacturing"
HOMEPAGE="http://gcam.js.cx"
SRC_URI="http://gcam.js.cx/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	x11-libs/gtkglext"
RDEPEND="${DEPEND}"
