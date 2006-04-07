# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.19-r1.ebuild,v 1.2 2006/04/07 13:30:38 tcort Exp $

inherit eutils python

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/quodlibet"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa esd flac gnome mad musepack oss vorbis"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.8
	>=x11-libs/gtk+-2.8
	>=media-libs/mutagen-1.0
	>=media-libs/gstreamer-0.10.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gst-plugins-good-0.10.2
	>=dev-python/gst-python-0.10.1
	mad? ( dev-python/pymad
		>=media-plugins/gst-plugins-mad-0.10.2 )
	vorbis? ( dev-python/pyvorbis
		>=media-plugins/gst-plugins-vorbis-0.10.0
		>=media-plugins/gst-plugins-ogg-0.10.0 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0
		>=dev-python/ctypes-0.9.6 )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.0
		>=media-libs/gst-plugins-bad-0.10.1
		media-libs/libmpcdec
		>=dev-python/ctypes-0.9.6 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.0 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.0 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10.0 )
	gnome? ( dev-python/gnome-python-extras
			>=media-plugins/gst-plugins-gnomevfs-0.10.0
			dev-python/feedparser )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/quodlibet-0.17.1-multilibfix.patch

	if use alsa; then
		epatch ${FILESDIR}/${P}-alsa.patch
	else
		if use oss; then
			epatch ${FILESDIR}/${P}-oss.patch
		fi
	fi
}

src_compile() {
	mkdir -p "${T}/home"
	export HOME="${T}/home"
	export GST_REGISTRY=${T}/home/registry.cache.xml

	addpredict /root/.gconfd
	addpredict /root/.gconf
	addpredict /var/lib/cache/gstreamer-0.10

	emake || die "emake failed"
	emake extensions || die "emake extensions failed"
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} libdir=$(get_libdir) install ||
		die "install failed"
	dodoc README NEWS
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}

