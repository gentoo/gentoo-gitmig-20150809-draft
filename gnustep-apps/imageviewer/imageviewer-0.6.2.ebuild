# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/imageviewer/imageviewer-0.6.2.ebuild,v 1.2 2004/07/23 14:59:18 fafhrd Exp $

inherit gnustep-old

DESCRIPTION="ImageViewer is a small image viewer"
HOMEPAGE="http://www.nice.ch/~phip/softcorner.html"
SRC_URI="http://www.nice.ch/~phip/ImageViewer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=gnustep-base/gnustep-gui-0.8.5"

S=${WORKDIR}/ImageViewer
