# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.5.1.ebuild,v 1.4 2004/03/14 17:23:19 mr_bones_ Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=kde-base/kdelibs-3.0
	>=kde-base/kdesdk-3.0
	>=media-gfx/gphoto2-2.0-r1"
