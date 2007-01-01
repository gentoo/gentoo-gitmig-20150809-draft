# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkexif/libkexif-0.2.1.ebuild,v 1.5 2007/01/01 13:24:25 centic Exp $

inherit kde

DESCRIPTION="A KDE library for loss-less EXIF operations."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/digikam/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 ~sparc"
IUSE=""

DEPEND="media-libs/libexif
	dev-util/pkgconfig"
RDEPEND="media-libs/libexif"
need-kde 3.1
