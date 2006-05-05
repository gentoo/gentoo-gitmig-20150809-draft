# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonik/sonik-1.0_beta2.ebuild,v 1.1 2006/05/05 10:34:48 eldad Exp $

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

pkg_setup()
{
	if useq !arts
	then
		eerror ""
		eerror "sonik requires arts in order to compile and run."
		eerror "please enable arts useflag."
		eerror ""

		die "arts useflag needed but is disabled."
	fi

	kde_pkg_setup
}

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
