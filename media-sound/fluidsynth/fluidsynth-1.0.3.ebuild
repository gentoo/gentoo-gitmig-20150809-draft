# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fluidsynth/fluidsynth-1.0.3.ebuild,v 1.19 2007/07/11 19:30:24 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="IIWU Synth is a software real-time synthesizer based on the Soundfont 2 specifications."
HOMEPAGE="http://www.fluidsynth.org/"
SRC_URI="http://savannah.nongnu.org/download/fluid/stable.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"

IUSE="alsa jack sse ladcca"

DEPEND="jack? ( media-sound/jack-audio-connection-kit )
	media-libs/ladspa-sdk
	ladcca? ( =media-libs/ladcca-0.3* )
	alsa? ( media-libs/alsa-lib )"

# ladcca-0.4 support is broken.  bug #46916

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-nonx86.patch
}

src_compile() {
	local myconf
	myconf="--enable-ladspa"
	#use ladcca || myconf="--disable-ladcca ${myconf}"
	use amd64 && myconf="`use_enable ladcca` ${myconf}" \
		|| myconf="--disable-ladcca ${myconf}"
	use alsa || myconf="--disable-alsa ${myconf}"
	use jack || myconf="--disable-jack-support ${myconf}"
	if use sse; then
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
