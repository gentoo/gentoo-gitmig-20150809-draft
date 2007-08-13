# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkipi/libkipi-0.1.5.ebuild,v 1.4 2007/08/13 21:01:36 dertobi123 Exp $

inherit kde

DESCRIPTION="A library for image plugins accross KDE applications."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE="kdehiddenvisibility"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

need-kde 3.4
