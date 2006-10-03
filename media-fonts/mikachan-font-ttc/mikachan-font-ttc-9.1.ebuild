# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font-ttc/mikachan-font-ttc-9.1.ebuild,v 1.1 2006/10/03 09:33:42 flameeyes Exp $

S="${WORKDIR}/${P/-ttc}"

inherit font

DESCRIPTION="Mikachan Japanese TrueType Collection fonts"
# taken from
#SRC_URI="http://mikachan.sourceforge.jp/mikachanALL.exe
#	http://mikachan.sourceforge.jp/puchi.exe"
SRC_URI="mirror://gentoo/${P/-ttc/}.tar.bz2
	http://dev.gentoo.org/~usata/${P/-ttc/}.tar.bz2"
HOMEPAGE="http://mikachan-font.com/"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttc"
