# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bombono-dvd/bombono-dvd-1.0.0.ebuild,v 1.10 2012/05/06 17:33:43 dilfridge Exp $

EAPI=2

inherit base toolchain-funcs flag-o-matic

DESCRIPTION="GUI DVD authoring program"
HOMEPAGE="http://www.bombono.org/"
SRC_URI="mirror://sourceforge/bombono/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 x86"

IUSE=""

RDEPEND="
	app-i18n/enca
	app-cdr/dvd+rw-tools
	dev-cpp/gtkmm:2.4
	dev-cpp/libxmlpp:2.6
	dev-libs/boost
	<dev-libs/glib-2.32.1
	media-libs/libdvdread
	media-sound/twolame
	media-video/dvdauthor
	virtual/ffmpeg
	>=media-video/mjpegtools-1.8.0
	x11-libs/gtk+:2
"

DEPEND=">=dev-util/scons-0.96.1
	${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-1.0.0-ffmpeg.patch" )

src_compile() {
	append-flags -DBOOST_FILESYSTEM_VERSION=2

	# scons options differ from make options -> remove everything except "-jX" and "-j X"
	local sconsopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[[:space:]]*[0-9]\+\).*/\1/; p }")

	scons CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" ${sconsopts} DESTDIR="${D}" PREFIX="/usr" \
		CPPFLAGS='-UBOOST_SYSTEM_NO_DEPRECATED' USE_EXT_BOOST=1 \
		|| die "Please add ${S}/config.opts when filing bugs reports!"
}

src_install() {
	scons install || die "Please add ${S}/config.opts when filing bugs reports!"
}
