# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonik/sonik-1.0_beta2.ebuild,v 1.2 2006/06/02 13:40:38 eldad Exp $

ARTS_REQUIRED="yes"

inherit eutils kde autotools

MY_PV="0.999.0.2"

DESCRIPTION="KDE Audio Editor"
HOMEPAGE="http://sonik.sourceforge.net/"
SRC_URI="mirror://sourceforge/sonik/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ladspa"

need-kde 3.3

RDEPEND="media-libs/liblrdf ladspa? ( media-libs/ladspa-sdk ) sci-libs/gsl"
DEPEND="${RDEPEND} media-libs/audiofile"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	eautoheader
	eautoconf

	myconf="$(use_enable ladspa)"
	kde_src_compile
}

src_install() {
	kde_src_install

	# collision protection
	rm -r ${D}/usr/include
}
