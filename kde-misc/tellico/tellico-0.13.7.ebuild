# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-0.13.7.ebuild,v 1.4 2005/08/13 23:19:47 hansmi Exp $

inherit kde

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico"
SRC_URI="http://www.periapsis.org/tellico/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="yaz"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19
	|| ( kde-base/libkcddb kde-base/kdemultimedia )
	media-libs/taglib
	yaz? ( dev-libs/yaz )"

need-kde 3.2
