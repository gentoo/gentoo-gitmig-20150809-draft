# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-1.0.1.ebuild,v 1.1 2005/09/24 20:20:18 carlo Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico"
SRC_URI="http://www.periapsis.org/tellico/download/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="yaz"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19
	|| ( kde-base/libkcddb kde-base/kdemultimedia )
	|| ( ( kde-base/ktnef kde-base/libkcal ) kde-base/kdepim )
	media-libs/taglib
	yaz? ( dev-libs/yaz )"

need-kde 3.4