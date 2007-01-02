# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkexif/libkexif-0.2.4.ebuild,v 1.4 2007/01/02 14:13:39 gustavoz Exp $

inherit kde

DESCRIPTION="A KDE library for loss-less EXIF operations."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/libexif-0.6.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
need-kde 3.4
