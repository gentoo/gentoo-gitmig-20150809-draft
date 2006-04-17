# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkipi/libkipi-0.1.2.ebuild,v 1.6 2006/04/17 12:25:25 dertobi123 Exp $

inherit kde

DESCRIPTION="A library for image plugins accross KDE applications."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
need-kde 3.1
