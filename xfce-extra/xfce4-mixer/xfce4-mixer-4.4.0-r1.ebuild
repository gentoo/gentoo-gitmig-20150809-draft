# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.4.0-r1.ebuild,v 1.2 2007/02/10 15:18:40 drac Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Mixer GUI and panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="alsa debug"

RDEPEND=">=dev-libs/glib-2.6
	dev-libs/libxml2
	>=x11-libs/gtk+-2.6
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

if use alsa; then
	XFCE_CONFIG="${XFCE_CONFIG} --with-sound=alsa"
fi

DOCS="AUTHORS ChangeLog NEWS NOTES README TODO"

src_install() {
	# .desktop file has allready been created by upstrean
	# and make install tries to create it again. Bug 166167
	rm panel-plugin/xfce4-mixer.desktop
	xfce44_src_install
	make_desktop_entry ${PN} "Volume control" ${PN} AudioVideo
}

xfce44_core_package
