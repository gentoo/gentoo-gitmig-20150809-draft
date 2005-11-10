# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-7.0.0_rc1.ebuild,v 1.9 2005/11/10 01:10:37 joshuabaergen Exp $

inherit eutils

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation (meta
package)"
HOMEPAGE="http://xorg.freedesktop.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
IUSE="xprint"

# Collision protect will scream bloody murder if we install over old versions
RDEPEND="!<x11-base/xorg-x11-7.0.0_rc0"

# Server
RDEPEND="${RDEPEND}
	>=x11-base/xorg-server-0.99.2"

# Common Applications
RDEPEND="${RDEPEND}
	>=x11-apps/setxkbmap-0.99.1
	>=x11-apps/xauth-0.99.1
	>=x11-apps/xhost-0.99.1
	>=x11-apps/xinit-0.99.2
	>=x11-apps/xmodmap-0.99.1
	>=x11-apps/xrandr-0.99.1"

# Common Libraries - move these to eclass eventually
RDEPEND="${RDEPEND}
	>=x11-libs/libSM-0.99.1
	>=x11-libs/libXcomposite-0.2.1
	>=x11-libs/libXcursor-1.1.4
	>=x11-libs/libXdamage-1.0.1
	>=x11-libs/libXfixes-3.0.0
	>=x11-libs/libXv-0.99.1
	>=x11-libs/libXxf86dga-0.99.1
	>=x11-libs/libXinerama-0.99.1
	>=x11-libs/libXScrnSaver-0.99.2
	xprint? ( >=x11-libs/libXp-0.99.1 )"

# Some fonts
RDEPEND="${RDEPEND}
	>=media-fonts/font-bh-ttf-0.99.0
	>=media-fonts/font-adobe-utopia-type1-0.99.0
	>=media-fonts/font-bitstream-type1-0.99.0"

DEPEND="${RDEPEND}"

# We need some checks for weird symlinks on migrate
# /usr/lib/X11/xdm -> ../../../etc/X11/xdm

pkg_postinst() {
	x-modular_pkg_postinst

	echo
	einfo "Please note that the xcursors are in /usr/share/cursors/${PN}."
	einfo "Any custom cursor sets should be placed in that directory."
	echo
	einfo "If you wish to set system-wide default cursors, please create"
	einfo "/usr/local/share/cursors/${PN}/default/index.theme"
	einfo "with content: \"Inherits=theme_name\" so that future"
	einfo "emerges will not overwrite those settings."
	echo
	einfo "Listening on TCP is disabled by default with startx."
	einfo "To enable it, edit /usr/bin/startx."
	echo

	ewarn "Please read the modular X migration guide at"
	ewarn "http://dev.gentoo.org/~spyderous/xorg-x11/migrating_to_modular_x_howto.txt"
	echo
	einfo "If you encounter any non-configuration issues, please file a bug at"
	einfo "http://bugs.gentoo.org/enter_bug.cgi?product=Gentoo%20Linux"
	einfo "and attach /etc/X11/xorg.conf, /var/log/Xorg.0.log and emerge info"
	echo
	einfo "In the future, you will be able to affect which drivers are installed"
	einfo "with the VIDEO_CARDS and INPUT_DEVICES settings."
	echo

	# (#76985)
	einfo "Visit http://www.gentoo.org/doc/en/index.xml?catid=desktop"
	einfo "for more information on configuring X."
	echo

	# Try to get people to read this, pending #11359
	ebeep 5
	epause 10
}
