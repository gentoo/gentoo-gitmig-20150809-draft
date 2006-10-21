# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonik/sonik-1.0.0.ebuild,v 1.2 2006/10/21 14:02:54 carlo Exp $

ARTS_REQUIRED="yes"

inherit kde

DESCRIPTION="KDE Audio Editor"
HOMEPAGE="http://sonik.sourceforge.net/"
SRC_URI="mirror://sourceforge/sonik/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ladspa"

RDEPEND="media-libs/liblrdf
	ladspa? ( media-libs/ladspa-sdk )
	sci-libs/gsl
	media-libs/audiofile"
need-kde 3.3

src_compile() {
	myconf="$(use_enable ladspa)"
	kde_src_compile
}
