# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.99.2.ebuild,v 1.5 2007/07/02 15:43:18 peper Exp $

inherit eutils

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/files/releases/${P/_/}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="nls debug sse altivec"

# From beta30 release notes:
#  plugin latency compensation now working correctly (we believe)
#  This really requires JACK 0.100.0 or above to work
#  properly, but even without that, they result in notable improvements
#  in the way Ardour aligns newly recorded material.
#
# As media-sound/jack-audio-connection-kit-0.100.0 is still -arch and it is not required for beta30
# only suggested, RDEPEND needs to be updated as media-sound/jack-audio-connection-kit-0.100.0 gets
# into ~arch. (2005 Sep 14 eldad)

RDEPEND="dev-util/pkgconfig
	>=media-libs/liblrdf-0.3.6
	>=media-libs/raptor-1.2.0
	>=media-sound/jack-audio-connection-kit-0.98.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.4
	sys-libs/gdbm
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/libsamplerate-0.0.14
	>=dev-libs/libxml2-2.5.7
	>=media-libs/libart_lgpl-2.3.16"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	dev-util/pkgconfig
	>=dev-util/scons-0.96.1
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_/}"

src_compile() {
	# bug 99664
	cd ${S}/libs/gtkmm
	chmod a+x autogen.sh && ./autogen.sh || die "autogen failed"
	econf || die "configure failed"

	# Required for scons to "see" intermediate install location
	mkdir -p ${D}

	use altivec && ALTIVEC=1 || ALTIVEC=0
	use debug && ARDOUR_DEBUG=1 || ARDOUR_DEBUG=0
	use nls && NLS=1 || NLS=0
	use sse && SSE=1 || SSE=0

	cd ${S}
	scons \
		ALTIVEC=${ALTIVEC} \
		DEBUG=${ARDOUR_DEBUG} \
		DESTDIR=${D} \
		NLS=${NLS} \
		PREFIX=/usr \
		USE_SSE_EVERYWHERE=${SSE} \
		KSI=0 \
		-j2 || die "scons make failed"
}

src_install() {
	scons install || die "make install failed"

	dodoc DOCUMENTATION/*
}

pkg_postinst() {
	if useq sse
	then
		elog "Start ardour with the -o argument to use the optimized SSE functions:"
		elog "	  ardour -o"
	fi
}

