# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.4_beta1.ebuild,v 1.5 2006/02/19 22:03:41 flameeyes Exp $

LANGS="az bg br ca cs cy da de el en_GB es et fi fr ga gl he hi hu is it ja ko lt nb nl nn pa pl pt pt_BR ro ru rw sl sr sr@Latn sv ta tg th tr uk uz xx zh_CN zh_TW"
LANGS_DOC="da de es et fr it nl pt pt_BR ru sv"

USE_KEG_PACKAGING=1

inherit kde eutils flag-o-matic

MY_P="${P/_rc/_RC}"
MY_P="${MY_P/_beta/-beta}"
S="${WORKDIR}/${MY_P/_RC*//}"

DESCRIPTION="amaroK - the audio player for KDE."
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://sourceforge/amarok/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac arts exscalibar flac gstreamer kde mysql noamazon opengl postgres xine xmms
visualization musicbrainz ipod akode real"
# kde: enables compilation of the konqueror sidebar plugin

DEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase )
		|| ( kde-base/kdemultimedia-kioslaves kde-base/kdemultimedia ) )
	arts? ( kde-base/arts
	        || ( kde-base/kdemultimedia-arts kde-base/kdemultimedia ) )
	xine? ( >=media-libs/xine-lib-1_rc4 )
	gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )
	musicbrainz? ( >=media-libs/tunepimp-0.3 )
	>=media-libs/taglib-1.4
	mysql? ( >=dev-db/mysql-4.0.16 )
	postgres? ( dev-db/postgresql )
	opengl? ( virtual/opengl )
	xmms? ( >=media-sound/xmms-1.2 )
	visualization? ( media-libs/libsdl
	                 >=media-plugins/libvisual-plugins-0.2 )
	ipod? ( media-libs/libgpod )
	akode? ( media-libs/akode )
	aac? ( media-libs/libmp4v2 )
	exscalibar? ( media-libs/exscalibar )
	real? ( media-video/realplayer )"

RDEPEND="${DEPEND}
	dev-lang/ruby"

DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.9.0"

need-kde 3.3

pkg_setup() {
	if use arts && ! use xine && ! use gstreamer; then
		ewarn "aRts support is deprecated, if you have problems please consider"
		ewarn "enabling support for Xine (preferred) or GStreamer"
		ewarn "(emerge amarok again with USE=\"xine\" or USE=\"gstreamer\")."
		ebeep 2
	fi

	if ! use arts && ! use xine && ! use gstreamer; then
		eerror "amaroK needs either aRts (deprecated), Xine (preferred) or GStreamer to work,"
		eerror "please try again with USE=\"arts\", USE=\"xine\" or USE=\"gstreamer\"."
		die
	fi

	# check whether kdelibs was compiled with arts support
	kde_pkg_setup

	append-flags -fno-inline
}

src_unpack() {
	kde_src_unpack

	# fix parallel make issues
	sed -i -e 's:$(top_builddir)/amarok/src/libamarok.la:libamarok.la:' \
		${S}/amarok/src/Makefile.am

	rm -f ${S}/configure
}

src_compile() {
	# amarok does not respect kde coding standards, and makes a lot of
	# assuptions regarding its installation directory. For this reason,
	# it must be installed in the KDE install directory.
	PREFIX="${KDEDIR}"

	# Extra, unsupported engines are forcefully disabled.
	local myconf="$(use_with arts) $(use_with xine) $(use_with gstreamer)
	              $(use_enable mysql) $(use_enable postgres postgresql)
	              $(use_with opengl) $(use_with xmms)
	              $(use_with visualization libvisual)
	              $(use_enable !noamazon amazon)
	              $(use_with musicbrainz)
	              $(use_with exscalibar)
				  $(use_with ipod libgpod)
				  $(use_with akode)
				  $(use_with aac mp4v2)
				  $(use_with real helix)
	              --without-mas
	              --without-nmm
				  --without-ifp
				  --without-gstreamer10"

	kde_src_compile
}

src_install() {
	kde_src_install

	# Workaround to use amaroK from outside KDE

	# move the desktop file in /usr/share
	dodir /usr/share/applications/kde
	mv ${D}${KDEDIR}/share/applications/kde/amarok.desktop \
		${D}/usr/share/applications/kde/amarok.desktop || die
	# move icons, too
	dodir /usr/share/icons
	mv ${D}${KDEDIR}/share/icons/hicolor \
		${D}/usr/share/icons || die
}

