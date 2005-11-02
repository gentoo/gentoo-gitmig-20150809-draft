# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-7.0.0_rc1.ebuild,v 1.2 2005/11/02 07:21:22 spyderous Exp $

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation (meta
package)"
HOMEPAGE="http://xorg.freedesktop.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
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
	>=x11-apps/xmodmap-0.99.1"

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
	xprint? ( >=x11-libs/libXp-0.99.1 )"

# Some fonts
RDEPEND="${RDEPEND}
	>=media-fonts/font-bh-ttf-0.99.0
	>=media-fonts/font-adobe-utopia-type1-0.99.0
	>=media-fonts/font-bitstream-type1-0.99.0"

DEPEND="${RDEPEND}"

# We need some checks for weird symlinks on migrate
# /usr/lib/X11/xdm -> ../../../etc/X11/xdm
