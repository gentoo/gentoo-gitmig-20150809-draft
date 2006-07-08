# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tunesbrowser/tunesbrowser-0.3.0-r1.ebuild,v 1.1 2006/07/08 17:13:13 fvdpol Exp $

IUSE="aac"

inherit eutils

DESCRIPTION="TunesBrowser is a simple music player, capable of playing music found in iTunes(R) shares"
HOMEPAGE="http://crazney.net/programs/itunes/tunesbrowser.html"
SRC_URI="http://crazney.net/programs/itunes/files/${P}.tar.bz2"
SLOT="0"
LICENSE="crazney"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="=media-libs/gstreamer-0.8*
	=media-plugins/gst-plugins-mad-0.8*
	=media-plugins/gst-plugins-oss-0.8*
	=media-libs/libopendaap-0.4*
	>=gnome-base/libglade-2.0
	aac? ( media-plugins/gst-plugins-faad )"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
}
