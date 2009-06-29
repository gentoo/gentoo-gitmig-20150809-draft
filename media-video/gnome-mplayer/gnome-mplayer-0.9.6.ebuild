# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.9.6.ebuild,v 1.6 2009/06/29 21:45:28 maekke Exp $

EAPI=2
GCONF_DEBUG=no
inherit autotools eutils gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://code.google.com/p/gnome-mplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	!gnome? ( mirror://gentoo/${P}-gconf-2.m4.tgz
		http://dev.gentoo.org/~ssuominen/${P}-gconf-2.m4.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="+alsa gnome ipod +libnotify musicbrainz"

RDEPEND="dev-libs/glib:2
	>=x11-libs/gtk+-2.12:2
	dev-libs/dbus-glib
	media-video/mplayer[ass]
	alsa? ( media-libs/alsa-lib )
	gnome? ( gnome-base/gconf:2
		gnome-base/gvfs
		gnome-base/nautilus )
	ipod? ( media-libs/libgpod )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( net-misc/curl
		media-libs/musicbrainz:3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	DOCS="ChangeLog README DOCS/keyboard_shortcuts.txt"
	G2CONF+=" --disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_enable gnome nautilus)
		--with-gio
		$(use_with gnome gconf)
		$(use_with alsa)
		$(use_with libnotify)
		$(use_with ipod libgpod)
		$(use_with musicbrainz libmusicbrainz3)"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=${WORKDIR} eautoreconf
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib # rm empty dir from destdir
}
