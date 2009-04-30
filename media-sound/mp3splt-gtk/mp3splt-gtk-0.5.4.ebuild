# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt-gtk/mp3splt-gtk-0.5.4.ebuild,v 1.1 2009/04/30 00:44:58 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="a GTK+ based utility to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3splt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="audacious gstreamer nls"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=media-libs/libmp3splt-0.5.4
	audacious? ( media-sound/audacious )
	gstreamer? ( media-libs/gst-plugins-base:0.10 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-validate_desktop_entry.patch
}

src_configure() {
	local myconf

	use nls || myconf+=" --disable-nls"
	use audacious && myconf+=" --enable-audacious"
	use gstreamer && myconf+=" --enable-gstreamer"

	econf --disable-dependency-tracking ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
