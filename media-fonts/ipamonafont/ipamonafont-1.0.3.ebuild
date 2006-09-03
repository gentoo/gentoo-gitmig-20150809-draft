# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ipamonafont/ipamonafont-1.0.3.ebuild,v 1.7 2006/09/03 06:39:19 vapier Exp $

inherit font

DESCRIPTION="Hacked version of IPA fonts, which is suitable for browsing 2ch"
HOMEPAGE="http://www.geocities.jp/ipa_mona/index.html"
MY_PN="opfc-ModuleHP-1.1.1_withIPAMonaFonts"
SRC_URI="http://www.geocities.jp/ipa_mona/${MY_PN}-${PV}.tar.gz"
LICENSE="grass-ipafonts as-is"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ppc s390 sh x86"
IUSE=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}/${MY_PN}/fonts"
