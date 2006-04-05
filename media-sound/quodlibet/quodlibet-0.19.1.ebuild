# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.19.1.ebuild,v 1.1 2006/04/05 13:50:46 tcort Exp $

inherit eutils python

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/quodlibet/"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="aac alsa esd flac gnome mad musepack oss vorbis"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.8
	>=x11-libs/gtk+-2.8
	>=media-libs/mutagen-1.1
	>=media-libs/gstreamer-0.10.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gst-plugins-good-0.10.2
	>=dev-python/gst-python-0.10.2
	mad? ( >=media-plugins/gst-plugins-mad-0.10.2 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.2
		>=media-plugins/gst-plugins-ogg-0.10.2
		<dev-python/pyvorbis-1.4* )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.2 )
	aac? ( media-libs/faad2
		>=media-plugins/gst-plugins-faad-0.10.1
		<dev-python/ctypes-0.9.9.3* )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.0
		>=media-libs/gst-plugins-bad-0.10.1
		media-libs/libmpcdec
		<dev-python/ctypes-0.9.9.3* )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.2 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.2 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10.2 )
	gnome? ( dev-python/gnome-python-extras
		>=media-plugins/gst-plugins-gnomevfs-0.10.2
		dev-python/feedparser )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/quodlibet-0.17.1-multilibfix.patch

	# set the default pipeline (alsasink|osssink|esdsink)
	( use alsa && epatch ${FILESDIR}/${PN}-0.19-alsa.patch ) ||
	( use oss  && epatch ${FILESDIR}/${PN}-0.19-oss.patch  ) ||
	( use esd  && epatch ${FILESDIR}/${PN}-0.19-esd.patch  )
}

src_compile() {
	emake extensions || die "emake extensions failed"
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} libdir=$(get_libdir) install ||
		die "install failed"
	dodoc README NEWS
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
