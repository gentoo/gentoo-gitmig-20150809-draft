# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.6.3.ebuild,v 1.1 2003/09/07 23:25:40 foser Exp $

inherit gst-plugins

KEYWORDS="~x86"

IUSE=""
DEPEND=">=gnome-base/gnome-vfs-2"

BUILD_GST_PLUGINS="gnome_vfs"
