# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-plugins-ugly/audacious-plugins-ugly-1.3.0.ebuild,v 1.2 2008/01/18 11:54:26 chainsaw Exp $

inherit flag-o-matic

DESCRIPTION="Plugins that are not portable code, or depend on unstable libraries."
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://static.audacious-media-player.org/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cube iris libnotify mplayer nls"

RDEPEND="!<media-plugins/audacious-plugins-1.3.0
	dev-libs/libxml2
	=media-sound/audacious-1.3*
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	media-libs/taglib
	iris? ( >=x11-libs/libXxf86vm-1.0.0 )
	libnotify? ( >=x11-libs/libnotify-0.4.2 )
	mplayer? ( media-video/mplayer )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

src_compile() {
	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		$(use_enable libnotify notify) \
		$(use_enable mplayer) \
		$(use_enable cube) \
		$(use_enable iris) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS
}
