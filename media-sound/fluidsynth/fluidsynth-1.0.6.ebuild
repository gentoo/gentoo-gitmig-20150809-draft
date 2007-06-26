# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fluidsynth/fluidsynth-1.0.6.ebuild,v 1.3 2007/06/26 02:13:57 mr_bones_ Exp $

IUSE="alsa jack sse ladcca static"

inherit flag-o-matic eutils

DESCRIPTION="IIWU Synth is a software real-time synthesizer based on the Soundfont 2 specifications."
HOMEPAGE="http://www.fluidsynth.org/"
SRC_URI="http://savannah.nongnu.org/download/fluid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="jack? ( media-sound/jack-audio-connection-kit )
	media-libs/ladspa-sdk
	alsa? ( media-libs/alsa-lib
	        ladcca? ( >=media-libs/ladcca-0.3 ) )"

# Alsa is required for ladcca support in this package.

src_unpack() {
	unpack ${A}

	cd ${S}
	use amd64 && epatch ${FILESDIR}/fluidsynth-1.0.6.amd64.patch
}

src_compile() {
	local myconf
	myconf="--enable-ladspa `use_enable jack jack-support` `use_enable static`"

	if use alsa; then
		myconf="${myconf} --enable-alsa `use_enable ladcca`"
	else
		myconf="${myconf} --disable-alsa --disable-ladcca"
	fi

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
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS TODO
}
