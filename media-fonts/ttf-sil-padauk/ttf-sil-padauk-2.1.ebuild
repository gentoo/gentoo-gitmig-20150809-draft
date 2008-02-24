# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-padauk/ttf-sil-padauk-2.1.ebuild,v 1.17 2008/02/24 12:32:22 armin76 Exp $

inherit font

DESCRIPTION="SIL Padauk - SIL fonts for Myanmar"
HOMEPAGE="http://scripts.sil.org/padauk"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="FONTLOG OFL-FAQ"
