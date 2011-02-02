# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kaudiocreator/kaudiocreator-1.2.90.ebuild,v 1.2 2011/02/02 04:27:39 tampakrap Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=107645"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/107645-${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdemultimedia-kioslaves)
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/libdiscid
	>=media-libs/taglib-1.5"

DOCS=( Changelog TODO )
