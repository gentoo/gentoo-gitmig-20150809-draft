# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc/xfce4-mpc-0.3.2.ebuild,v 1.2 2007/05/31 15:26:51 welp Exp $

inherit xfce44

xfce44
xfce44_gzipped

# Fails when entering po/ and upstream doesn't care about it.
RESTRICT="test"

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=media-sound/mpd-0.12.1"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-perl/XML-Parser"

# Upstream preferred way for this release. Open a bug if you find
# --enable-libmpd someway more useful or more stable.
XFCE_CONFIG="${XFCE_CONFIG} --disable-libmpd"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
