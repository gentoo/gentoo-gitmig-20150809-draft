# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core-libs/gnome-core-libs-3.2.1.ebuild,v 1.1 2011/11/07 07:48:08 tetromino Exp $

EAPI="4"

DESCRIPTION="Sub-meta package for the core libraries of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="3.0"
IUSE="cups python"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# Note to developers:
# This is a wrapper for the core libraries used by GNOME 3
RDEPEND="
	>=dev-libs/glib-2.30.1:2
	>=x11-libs/gdk-pixbuf-2.24:2
	>=x11-libs/pango-1.29.3
	>=media-libs/clutter-1.8.2:1.0
	>=x11-libs/gtk+-${PV}:3[cups?]
	>=dev-libs/atk-2.2
	>=x11-libs/libwnck-${PV}:3
	>=gnome-base/librsvg-2.34.1[gtk]
	>=gnome-base/gnome-desktop-${PV}:3
	>=gnome-base/libgnomekbd-3.2
	>=x11-libs/startup-notification-0.10

	>=gnome-base/gvfs-1.10.1
	>=gnome-base/dconf-0.10

	>=media-libs/gstreamer-0.10.35:0.10
	>=media-libs/gst-plugins-base-0.10.35:0.10
	>=media-libs/gst-plugins-good-0.10.30:0.10

	python? ( >=dev-python/pygobject-3.0.1:3 )
"
DEPEND=""
S=${WORKDIR}
