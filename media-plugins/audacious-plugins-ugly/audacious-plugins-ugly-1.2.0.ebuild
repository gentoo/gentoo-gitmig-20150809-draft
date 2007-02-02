# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-plugins-ugly/audacious-plugins-ugly-1.2.0.ebuild,v 1.2 2007/02/02 02:59:36 beandog Exp $

inherit flag-o-matic

DESCRIPTION="Plugins that are not portable code, or depend on unstable libraries."
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://audacious-media-player.org/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify mplayer nls"

RDEPEND="dev-libs/libxml2
	>=media-sound/audacious-1.2.1
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	media-libs/taglib
	libnotify? ( x11-libs/libnotify )
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
		--enable-sap \
		$(use_enable libnotify notify) \
		$(use_enable mplayer) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS
}
