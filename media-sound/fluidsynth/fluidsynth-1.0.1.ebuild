# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fluidsynth/fluidsynth-1.0.1.ebuild,v 1.7 2004/04/08 07:52:53 eradicator Exp $

DESCRIPTION="IIWU Synth is a software real-time synthesizer based on the Soundfont 2 specifications."
HOMEPAGE="http://www.fluidsynth.org/"
SRC_URI="http://savannah.nongnu.org/download/fluid/stable.pkg/1.0.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="alsa"

DEPEND="media-libs/ladspa-sdk \
	alsa? ( media-libs/alsa-lib )"

# Removed as it doesn't support new ladcca yet ... bug #46916
# ladcca? ( media-libs/ladcca ) \

src_compile() {
	local myconfig
	myconfig="--enable-jack-support --enable-ladspa"
#	use ladcca || myconfig="--disable-ladcca ${myconfig}"
	use alsa || myconfig="--disable-alsa ${myconfig}"
	# use sse && myconfig="--enable-SSE ${myconfig}"
	# NOTE: sse use variable is broken now to do a missing header file in
	# the current release. Waiting for new release to fix.
	./configure \
		${myconfig} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc AUTHORS COPYING INSTALL NEWS README THANKS TODO
}

