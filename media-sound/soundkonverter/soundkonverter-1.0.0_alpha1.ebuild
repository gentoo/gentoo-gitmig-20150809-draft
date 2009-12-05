# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-1.0.0_alpha1.ebuild,v 1.1 2009/12/05 17:38:07 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A frontend to various audio converters"
HOMEPAGE="http://www.kde-apps.org/content/show.php/soundKonverter?content=29024"
SRC_URI="http://api.opensuse.org/public/source/home:HessiJames/${PN}-kde4/${P/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="!${CATEGORY}/${PN}:0"
DEPEND="${RDEPEND}
	media-sound/cdparanoia
	media-libs/taglib"

S=${WORKDIR}/${P/_}

DOCS="README TODO"
