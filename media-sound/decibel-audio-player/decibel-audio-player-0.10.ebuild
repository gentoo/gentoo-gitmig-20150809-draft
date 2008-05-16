# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/decibel-audio-player/decibel-audio-player-0.10.ebuild,v 1.1 2008/05/16 05:50:01 aballier Exp $

DESCRIPTION="A GTK+ audio player which aims at being very straightforward to use."
HOMEPAGE="http://decibel.silent-blade.org"
SRC_URI="http://decibel.silent-blade.org/uploads/Main/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac cdaudio gnome libnotify musepack"

RDEPEND="media-libs/mutagen
		dev-python/dbus-python
		dev-python/gnome-python
		dev-python/gst-python
		>=media-plugins/gst-plugins-meta-0.10-r2
		aac? ( media-plugins/gst-plugins-faad )
		cdaudio? ( media-plugins/gst-plugins-cdparanoia
					dev-python/cddb-py )
		gnome? ( dev-python/gnome-python-desktop )
		libnotify? ( dev-python/notify-python )
		musepack? ( media-plugins/gst-plugins-musepack )"

DEPEND="sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" prefix=/usr \
	install || die "emake install failed"
	dodoc doc/ChangeLog || die "dodoc failed"
}

