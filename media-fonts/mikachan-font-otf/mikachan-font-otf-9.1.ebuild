# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font-otf/mikachan-font-otf-9.1.ebuild,v 1.3 2006/10/04 16:12:11 wolf31o2 Exp $

S="${WORKDIR}/${P}"

inherit font

DESCRIPTION="Mikachan Japanese TrueType Collection fonts"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~flameeyes/dist/${P}.tar.bz2"
HOMEPAGE="http://mikachan-font.com/"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="otf"
