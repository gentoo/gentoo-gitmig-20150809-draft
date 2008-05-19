# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mgopen/mgopen-1.0.ebuild,v 1.1 2008/05/19 23:18:40 dirtyepic Exp $

inherit font

DISTDATE="20080519"

DESCRIPTION="Magenta MgOpen Typeface Collection for Modern Greek."
HOMEPAGE="http://www.ellak.gr/fonts/mgopen/index.en.html"
# unversioned distfile.  mirror locally.
SRC_URI="mirror://gentoo/MgOpen-${DISTDATE}.tar.gz"

LICENSE="MagentaMgOpen"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}
FONT_S=${S}

FONT_SUFFIX="ttf"
