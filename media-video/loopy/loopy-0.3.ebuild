# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/loopy/loopy-0.3.ebuild,v 1.2 2011/02/02 05:19:56 tampakrap Exp $

EAPI=3
KDE_LINGUAS="de"
inherit kde4-base

MY_P=${PN}_${PV}

DESCRIPTION="A simple video player for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Loopy?content=120880"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/120880-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${MY_P}

DOCS=( THEMING )
