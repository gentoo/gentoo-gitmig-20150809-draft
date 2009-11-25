# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.2.0.ebuild,v 1.1 2009/11/25 18:35:49 ssuominen Exp $

EAPI=2
KDE_LINGUAS="de en_GB ru tr"
inherit kde4-base

DESCRIPTION="a touchpad management tool for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/synaptiks?content=114270"
SRC_URI="http://bitbucket.org/lunar/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/libXi"

DOCS="CHANGES README"
