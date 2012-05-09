# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmusicbrowser/gmusicbrowser-1.1.9.ebuild,v 1.2 2012/05/09 00:01:12 hasufell Exp $

# note: dev-perl/Gtk2-MozEmbed left out in purpose because gtkmozembed and xulrunner are obsolete

EAPI=4
inherit fdo-mime

DESCRIPTION="An open-source jukebox for large collections of mp3/ogg/flac files"
HOMEPAGE="http://gmusicbrowser.org/"
SRC_URI="http://${PN}.org/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gstreamer libnotify mplayer webkit"

RDEPEND="dev-lang/perl
	dev-perl/AnyEvent-HTTP
	dev-perl/gnome2-wnck
	dev-perl/gtk2-perl
	dev-perl/gtk2-trayicon
	dev-perl/MP3-Tag
	virtual/perl-MIME-Base64
	dbus? ( dev-perl/Net-DBus )
	gstreamer? (
		dev-perl/GStreamer
		dev-perl/GStreamer-Interfaces
		media-plugins/gst-plugins-meta
	)
	!gstreamer? ( !mplayer? (
		media-sound/alsa-utils
		media-sound/flac123
		|| ( media-sound/mpg123 media-sound/mpg321 )
		media-sound/vorbis-tools
	) )
	libnotify? ( dev-perl/Gtk2-Notify )
	mplayer? ( || ( media-video/mplayer media-video/mplayer2 ) )
	webkit? ( dev-perl/Gtk2-WebKit )"
DEPEND="sys-devel/gettext"

LANGS="cs de es fr hu it ko nl pl pt pt_BR ru sv zh_CN"
for l in ${LANGS}; do
	IUSE="$IUSE linguas_${l}"
done
unset l

src_prepare() {
	sed -i -e '/menudir/d' Makefile || die
}

src_install() {
	local LINGUAS
	local l
	for l in ${LANGS}; do
		if use linguas_${l}; then
			LINGUAS="${LINGUAS} ${l}"
		fi
	done

	emake \
		DOCS="AUTHORS NEWS README" \
		DESTDIR="${D}" \
		iconsdir="${D}/usr/share/pixmaps" \
		LINGUAS="${LINGUAS}" \
		install

	dohtml layout_doc.html
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
