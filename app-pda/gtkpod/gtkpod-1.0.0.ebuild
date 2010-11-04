# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-1.0.0.ebuild,v 1.2 2010/11/04 17:15:31 fauli Exp $

EAPI=3

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="aac curl flac mp3 ogg"

RDEPEND=">=dev-libs/glib-2.16:2
	>=gnome-base/libglade-2.4
	>=media-libs/libgpod-0.7
	>=media-libs/libid3tag-0.15
	>=x11-libs/gtk+-2.8:2
	aac? ( media-libs/libmp4v2 )
	curl? ( >=net-misc/curl-7.10 )
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	ogg? ( media-libs/libvorbis
		media-sound/vorbis-tools )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	dev-util/intltool
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with curl) \
		$(use_with ogg) \
		$(use_with flac)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF}/html \
		install || die

	dodoc AUTHORS NEWS README TODOandBUGS.txt TROUBLESHOOTING
}
