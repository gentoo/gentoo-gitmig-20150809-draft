# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.99.14.ebuild,v 1.8 2009/07/10 16:14:17 ssuominen Exp $

EAPI=2
DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="aac flac gnome hal mp3 ogg"

DEPEND=">=x11-libs/gtk+-2.6.0
	>=media-libs/libid3tag-0.15
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomecanvas-2.14
	>=media-libs/libgpod-0.7.0
	>=net-misc/curl-7.10
	mp3? ( media-sound/lame )
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	hal? ( =sys-apps/hal-0.5* )
	aac? ( media-libs/libmp4v2 )
	ogg? ( media-libs/libvorbis
		media-sound/vorbis-tools )
	flac? ( media-libs/flac )"

src_prepare() {
	# Disable aac forcefully if not enabled
	use aac || sed -i -e s/MP4FileInfo/MP4FileInfoDisabled/g "${S}"/configure
}

src_configure() {
	econf \
		$(use_with hal) \
		$(use_with aac mp4v2) \
		$(use_with ogg) \
		$(use_with flac) \
		$(use_with gnome gnome-vfs)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TROUBLESHOOTING
}
