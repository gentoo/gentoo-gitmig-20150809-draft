# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.99.16.ebuild,v 1.1 2010/04/07 14:59:24 tester Exp $

EAPI=2
inherit eutils

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac mp3 nls ogg"

RDEPEND=">=x11-libs/gtk+-2.8
	>=media-libs/libid3tag-0.15
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomecanvas-2.14
	>=media-libs/libgpod-0.7
	>=net-misc/curl-7.10
	>=dev-libs/glib-2.16.0
	mp3? ( media-sound/lame )
	aac? ( media-libs/libmp4v2 )
	ogg? ( media-libs/libvorbis
		media-sound/vorbis-tools )
	flac? ( media-libs/flac )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with ogg) \
		$(use_with flac)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TROUBLESHOOTING *.txt
}
