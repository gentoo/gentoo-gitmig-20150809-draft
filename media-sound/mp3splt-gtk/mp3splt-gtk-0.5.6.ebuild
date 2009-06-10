# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt-gtk/mp3splt-gtk-0.5.6.ebuild,v 1.1 2009/06/10 17:27:49 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="a GTK+ based utility to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3splt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="audacious gstreamer nls"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=media-libs/libmp3splt-0.5.6
	audacious? ( media-sound/audacious )
	gstreamer? ( media-libs/gst-plugins-base:0.10 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	local myconf="--with-mp3splt-libraries=/usr/$(get_libdir)
		--with-mp3splt-includes=/usr/include/libmp3splt"

	use nls || myconf+=" --disable-nls"
	use audacious || myconf+=" --disable-audacious"
	use gstreamer || myconf+=" --disable-gstreamer"

	econf \
		--disable-dependency-tracking \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
