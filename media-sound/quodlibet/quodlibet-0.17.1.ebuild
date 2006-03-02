# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.17.1.ebuild,v 1.1 2006/03/02 19:04:12 metalgod Exp $

inherit eutils virtualx

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/quodlibet"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mad vorbis flac aac musepack mikmod alsa oss esd gnome"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.6.1
	>=dev-python/gst-python-0.8.2
	dev-python/ctypes
	mad? ( dev-python/pymad
	>=media-plugins/gst-plugins-mad-0.10.0 )
	vorbis? ( dev-python/pyvorbis
	>=media-plugins/gst-plugins-vorbis-0.10.0
	>=media-plugins/gst-plugins-ogg-0.10.0 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.0 )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.0 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.0 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.0 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10.0 )
	gnome? ( dev-python/gnome-python-extras
	>=media-plugins/gst-plugins-gnomevfs-0.10.0
	dev-python/feedparser )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-multilibfix.patch

}
src_compile() {
	Xemake || die "make failed"
	Xemake extensions || die "make extensions failed"
}

src_install() {
	Xmake PREFIX=/usr DESTDIR=${D} install || die "make install failed"

	dodoc README NEWS
}
