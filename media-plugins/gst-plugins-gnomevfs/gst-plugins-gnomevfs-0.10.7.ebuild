# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.10.7.ebuild,v 1.2 2006/09/04 06:43:17 vapier Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.7
		 >=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gnome_vfs"

