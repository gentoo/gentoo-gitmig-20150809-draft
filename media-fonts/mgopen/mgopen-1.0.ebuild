# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mgopen/mgopen-1.0.ebuild,v 1.3 2009/09/29 00:11:30 dirtyepic Exp $

inherit font

DISTDATE="20080519"

DESCRIPTION="Magenta MgOpen Typeface Collection for Modern Greek."
HOMEPAGE="http://www.zvr.gr/typo/mgopen/index"
# unversioned distfile.  mirror locally.
SRC_URI="mirror://gentoo/MgOpen-${DISTDATE}.tar.gz"

LICENSE="MagentaMgOpen"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}
FONT_S=${S}

FONT_SUFFIX="ttf"
