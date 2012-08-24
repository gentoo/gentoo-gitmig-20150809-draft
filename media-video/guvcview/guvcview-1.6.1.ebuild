# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.6.1.ebuild,v 1.1 2012/08/24 18:48:00 ssuominen Exp $

EAPI=4
inherit autotools

MY_P=${PN}-src-${PV}

DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

RDEPEND=">=dev-libs/glib-2.10
	media-libs/libpng:0
	>=media-libs/libsdl-1.2.10
	media-libs/libv4l
	>=media-libs/portaudio-19_pre
	sys-fs/udev
	virtual/ffmpeg
	x11-libs/gtk+:3
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/^docdir/,/^$/d' Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		--disable-debian-menu \
		$(use_enable pulseaudio pulse)
}
