# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/imageviewer/imageviewer-0.6.2.ebuild,v 1.3 2003/10/26 09:10:15 vapier Exp $

inherit gnustep

DESCRIPTION="ImageViewer is a small image viewer"
HOMEPAGE="http://www.nice.ch/~phip/softcorner.html"
SRC_URI="http://www.nice.ch/~phip/ImageViewer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-util/gnustep-gui-0.8.5"

S=${WORKDIR}/ImageViewer
