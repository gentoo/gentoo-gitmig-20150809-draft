# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/paratype/paratype-1.ebuild,v 1.1 2011/01/13 23:53:20 dirtyepic Exp $

EAPI="3"
inherit font

DESCRIPTION="ParaType font collection for languages of Russia"
HOMEPAGE="http://www.paratype.ru/public/"
SRC_URI="http://www.fontstock.com/public/PTSansOFL.zip
	http://www.fontstock.com/public/PTSerifOFL.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
