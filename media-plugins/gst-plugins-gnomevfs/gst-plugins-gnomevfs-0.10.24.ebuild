# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.10.24.ebuild,v 1.7 2009/11/27 15:20:47 maekke Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm hppa ~ia64 ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	>=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GST_PLUGINS_BUILD="gnome_vfs"
