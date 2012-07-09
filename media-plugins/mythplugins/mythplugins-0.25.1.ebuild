# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythplugins/mythplugins-0.25.1.ebuild,v 1.1 2012/07/09 00:05:18 cardoe Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
#BACKPORTS=""
MY_P=${P%_p*}

inherit eutils python

DESCRIPTION="Official MythTV plugins"
HOMEPAGE="http://www.mythtv.org"
SRC_URI="ftp://ftp.osuosl.org/pub/mythtv/mythplugins-0.25.1.tar.bz2
	${BACKPORTS:+http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-${BACKPORTS}.tar.xz}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MYTHPLUGINS="mytharchive mythbrowser mythgallery mythgame \
mythmusic mythnetvision mythnews mythweather"

IUSE="${MYTHPLUGINS} cdr exif fftw opengl projectm raw"

DEPEND="!media-plugins/mytharchive
	!media-plugins/mythbrowser
	!media-plugins/mythgallery
	!media-plugins/mythgame
	!media-plugins/mythmovies
	!media-plugins/mythmusic
	!media-plugins/mythnetvision
	!media-plugins/mythnews
	!media-plugins/mythweather
	=media-tv/mythtv-${MY_P}*[python]
	mytharchive? (
		app-cdr/dvd+rw-tools
		dev-python/imaging
		media-video/dvdauthor
		media-video/mjpegtools[png]
		media-video/transcode
		virtual/cdrtools
	)
	mythgallery? (
		media-libs/tiff
		exif? ( >media-libs/exif-0.6.9 )
		opengl? ( virtual/opengl )
		raw? ( media-gfx/dcraw )
	)
	mythmusic? (
		dev-libs/libcdio
		media-gfx/dcraw
		>=media-libs/flac-1.1.2
		>=media-libs/libmad-0.15.1b
		>=media-libs/libvorbis-1.0
		>=media-libs/taglib-1.4
		cdr? ( virtual/cdrtools )
		fftw? ( sci-libs/fftw )
		opengl? ( virtual/opengl )
		projectm? (
			>=media-libs/libsdl-1.2.5[opengl]
			=media-libs/libvisual-0.4*
			media-plugins/libvisual-projectm
		)
	)
	mythnetvision? (
		dev-python/lxml
		dev-python/mysql-python
		dev-python/oauth
		dev-python/pycurl
	)
	mythweather? (
		dev-perl/DateManip
		dev-perl/DateTime-Format-ISO8601
		dev-perl/ImageSize
		dev-perl/SOAP-Lite
		dev-perl/XML-Simple
		dev-perl/XML-Parser
		dev-perl/XML-SAX
		dev-perl/XML-XPath
	)"
RDEPEND="${DEPEND}"

REQUIRED_USE="
	cdr? ( mythmusic )
	exif? ( mythgallery )
	fftw? ( mythmusic )
	mythnews? ( mythbrowser )
	opengl? ( || ( mythgallery mythmusic ) )
	projectm? ( mythmusic )
	raw? ( mythgallery )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	epatch_user
}

src_configure() {
	./configure \
		--prefix=/usr \
		--python=python2 \
		--disable-mythzoneminder \
		$(use_enable mytharchive) \
		$(use_enable mythbrowser) \
		$(use_enable mythgallery) \
		$(use_enable mythgame) \
		$(use_enable mythmusic) \
		$(use_enable mythnetvision) \
		$(use_enable mythnews) \
		$(use_enable mythweather) \
		$(use_enable exif) \
		$(use_enable exif new-exif) \
		$(use_enable opengl) \
		$(use_enable raw dcraw) \
		|| die "configure failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"
}
