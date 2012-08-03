# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/source-sans-pro/source-sans-pro-2012.07.31.ebuild,v 1.1 2012/08/03 00:03:46 nirbheek Exp $

EAPI="4"

inherit font

DESCRIPTION="Adobe Source Sans Pro, an open source multi-lingual font family"
HOMEPAGE="http://blogs.adobe.com/typblography/2012/08/source-sans-pro.html"
SRC_URI="mirror://sourceforge/sourcesans.adobe/SourceSansPro_FontsOnly.zip -> SourceSansPro_FontsOnly-2012.07.31.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/fontconfig"
DEPEND=""

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

S="${WORKDIR}"

# Font eclass settings
DOCS="ReadMe.html SourceSansProReadMe.html"
FONT_S="${S}"
FONT_SUFFIX="otf ttf"

src_prepare() {
	default
	# Put otf and ttf files in one directory so that font_src_install can
	# actually find them
	mv OTF/* TTF/* . || die
}
