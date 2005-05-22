# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font/mikachan-font-9.1.ebuild,v 1.1 2005/05/22 11:17:02 usata Exp $

inherit font

MY_PN="${PN/-/}"

DESCRIPTION="Mikachan Japanese TrueType fonts"
# taken from
#SRC_URI="http://mikachan.sourceforge.jp/mikachanALL.exe
#	http://mikachan.sourceforge.jp/puchi.exe"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~usata/${P}.tar.bz2"
HOMEPAGE="http://mikachan-font.com/"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE=""

FONT_SUFFIX="ttc"
