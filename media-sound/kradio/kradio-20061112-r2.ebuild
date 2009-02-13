# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-20061112-r2.ebuild,v 1.1 2009/02/13 20:38:37 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

MY_PV="snapshot-2006-11-12-r497"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="KRadio is a radio tuner application for KDE."
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="alsa lirc encode vorbis v4l2 oss"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"
need-kde 3.5

PATCHES=(
	"${FILESDIR}/kradio-20061112-gcc43.patch"
	"${FILESDIR}/kradio-20061112-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack
	rm "${S}"/configure
}

src_compile() {
	if ! use vorbis; then
		myconf="${myconf} --enable-ogg=no"
	fi
	if ! use encode; then
		myconf="${myconf} --enable-lame=no"
	fi
	if ! use lirc; then
		myconf="${myconf} --enable-lirc=no"
	fi
	if ! use alsa; then
		myconf="${myconf} --enable-alsa=no"
	fi
	if ! use v4l2; then
		myconf="${myconf} --enable-v4l2=no"
	fi
	if ! use oss; then
		myconf="${myconf} --enable-oss=no"
	fi
	kde_src_compile || die "make failed"
}
