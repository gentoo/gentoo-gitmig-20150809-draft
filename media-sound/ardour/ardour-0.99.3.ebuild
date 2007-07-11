# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.99.3.ebuild,v 1.5 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/files/releases/${P/_/}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="nls debug sse altivec"

RDEPEND="dev-util/pkgconfig
	>=media-libs/liblrdf-0.3.6
	>=media-libs/raptor-1.2.0
	>=media-sound/jack-audio-connection-kit-0.100.0
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

	(useq altivec || useq sse) && FPU_OPTIMIZATION=1 || FPU_OPTIMIZATION=0
	useq debug && ARDOUR_DEBUG=1 || ARDOUR_DEBUG=0
	useq nls && NLS=1 || NLS=0

	cd ${S}
	scons \
		DEBUG=${ARDOUR_DEBUG} \
		FPU_OPTIMIZATION=${FPU_OPTIMIZATION} \
		DESTDIR=${D} \
		NLS=${NLS} \
		PREFIX=/usr \
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
