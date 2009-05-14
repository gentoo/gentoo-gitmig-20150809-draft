# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.8.7-r1.ebuild,v 1.3 2009/05/14 13:03:03 scarabeus Exp $

EAPI="2"

ARTS_REQUIRED="never"

inherit eutils kde flag-o-matic

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dvb gstreamer xinerama vorbis encode xcb"
# kdehiddenvisibility removed due to bug 207002.

RDEPEND=">=media-libs/xine-lib-1.1.9[xcb?]
	xcb? ( >=x11-libs/libxcb-1.0 )
	gstreamer? ( =media-libs/gstreamer-0.10*
		=media-plugins/gst-plugins-xvideo-0.10* )
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )
	x11-proto/inputproto"

need-kde 3.5.4

PATCHES=(
	"${FILESDIR}/kaffeine-0.8.7-respectcflags.patch"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_prepare() {
	:
}

src_configure() {
	# see bug #143168
	replace-flags -O3 -O2

	# workaround bug #198973
	local save_CXXFLAGS="${CXXFLAGS}"
	append-flags -std=gnu89
	export CXXFLAGS="${save_CXXFLAGS}"

	local myconf="${myconf}
		$(use_with xinerama)
		$(use_with dvb)
		$(use_with gstreamer)
		$(use_with vorbis oggvorbis)
		$(use_with xcb)
		$(use_with encode lame)"

	kde_src_configure
}

src_install() {
	kde_src_install

	# fix localization, bug #199909
	for mofile in "${D}/${KDEDIR}"/share/locale/*/LC_MESSAGES/${P}.mo ; do
		mv -f ${mofile} ${mofile/${P}.mo/${PN}.mo} \
			|| die "fixing mo files failed"
	done

	# remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}/${KDEDIR}"/share/mimelnk/application/x-mplayer2.desktop
}
