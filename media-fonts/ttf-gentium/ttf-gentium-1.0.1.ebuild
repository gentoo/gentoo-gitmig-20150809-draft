# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-gentium/ttf-gentium-1.0.1.ebuild,v 1.8 2006/09/03 06:46:05 vapier Exp $

inherit font

MY_P="fonts-${P}"

DESCRIPTION="Gentium Typeface"
HOMEPAGE="http://scripts.sil.org/gentium"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
#SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=Gentium_101_LT&_sc=1"

LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="X"

# DEPEND is defined in font.eclass
#DEPEND="X? ( virtual/x11 )"

DOCS="CHANGELOG FAQ HISTORY ISSUES QUOTES README THANKS
	local.conf *.pdf"
FONT_SUFFIX="ttf"
S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
