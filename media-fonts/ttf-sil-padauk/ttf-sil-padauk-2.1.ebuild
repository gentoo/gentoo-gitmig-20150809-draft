# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-padauk/ttf-sil-padauk-2.1.ebuild,v 1.12 2008/01/20 14:16:25 ranger Exp $

inherit font

DESCRIPTION="SIL Padauk - SIL fonts for Myanmar"
HOMEPAGE="http://scripts.sil.org/padauk"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="FONTLOG OFL-FAQ"
