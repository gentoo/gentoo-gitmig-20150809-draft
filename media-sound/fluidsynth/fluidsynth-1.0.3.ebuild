# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fluidsynth/fluidsynth-1.0.3.ebuild,v 1.4 2004/03/21 20:58:51 dholm Exp $

inherit flag-o-matic

DESCRIPTION="IIWU Synth is a software real-time synthesizer based on the
Soundfont 2 specifications."
HOMEPAGE="http://www.fluidsynth.org/"
SRC_URI="http://savannah.nongnu.org/download/fluid/stable.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="alsa ladcca jack sse"

DEPEND="ladcca? ( media-libs/ladcca ) \
	jack? ( virtual/jack ) \
	media-libs/ladspa-sdk \
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-nonx86.patch
}

src_compile() {
	local myconf
	myconf="--enable-ladspa"
	use ladcca || myconf="--disable-ladcca ${myconf}"
	use alsa || myconf="--disable-alsa ${myconf}"
	use jack || myconf="--disable-jack-support ${myconf}"
	if [ `use sse` ]; then
		myconf="--enable-SSE ${myconf}"
		# If your CFLAGS include optimizations for sse, ie:
		# -march=pentium4 -mfpmath=sse -msse2
		# AND your USE flags include sse, ie: USE=sse,
		# the sounds with fluidsynth will be distorted. 
		if [ `is-flag "-march=pentium4"` ]; then
			filter-flags "-msse2"
			filter-flags "-mfpmath=sse"
		fi
	fi
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README THANKS TODO
}


