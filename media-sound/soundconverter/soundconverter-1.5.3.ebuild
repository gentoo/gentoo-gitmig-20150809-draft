# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-1.5.3.ebuild,v 1.1 2010/11/21 18:05:01 hanno Exp $

inherit gnome2

DESCRIPTION="A simple sound converter application for the GNOME environment."
HOMEPAGE="http://soundconverter.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac flac mp3 vorbis"

# upstream reported, please remove as soon as it's fixed
# http://developer.berlios.de/bugs/?func=detailbug&bug_id=17726&group_id=3213
RESTRICT="test"

RDEPEND=">=dev-python/pygtk-2.12
	>=dev-python/gnome-python-2.12
	gnome-base/libglade
	gnome-base/gconf
	=dev-python/gst-python-0.10*
	=media-plugins/gst-plugins-gnomevfs-0.10*
	vorbis? (
		=media-plugins/gst-plugins-vorbis-0.10*
		=media-plugins/gst-plugins-ogg-0.10*
	)
	mp3? (
		=media-plugins/gst-plugins-lame-0.10*
		=media-plugins/gst-plugins-mad-0.10*
		=media-plugins/gst-plugins-taglib-0.10*
	)
	flac? ( =media-plugins/gst-plugins-flac-0.10* )
	aac? ( =media-plugins/gst-plugins-faac-0.10* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README TODO"
