# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc/xfce4-mpc-0.3.2.ebuild,v 1.5 2007/10/26 13:34:47 angelos Exp $

inherit autotools xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="dev-util/intltool
	dev-perl/XML-Parser"

# Upstream preferred way for this release. Open a bug if you find
# --enable-libmpd someway more useful or more stable.
XFCE_CONFIG="${XFCE_CONFIG} --disable-libmpd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^AC_INIT/s/mpc_version()/mpc_version/" configure.ac
	eautoconf
}

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
