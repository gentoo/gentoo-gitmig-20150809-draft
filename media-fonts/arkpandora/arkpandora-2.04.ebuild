# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arkpandora/arkpandora-2.04.ebuild,v 1.3 2004/12/14 16:43:50 corsair Exp $

inherit font

IUSE=""

MY_P="ttf-${P}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Arkpandora MS-TTF replacement font pack"
HOMEPAGE="http://www.users.bigpond.net.au/gavindi/"
SRC_URI="http://www.users.bigpond.net.au/gavindi/${MY_P}.tgz"

LICENSE="BitstreamVera"
SLOT="0"
KEYWORDS="~x86 ppc64"

FONT_S="${S}"
FONT_SUFFIX="ttf"

DOCS="CHANGELOG.TXT COPYRIGHT.TXT local.conf.arkpandora"
