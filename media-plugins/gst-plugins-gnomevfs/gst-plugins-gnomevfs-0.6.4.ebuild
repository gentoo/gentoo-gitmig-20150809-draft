# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.6.4.ebuild,v 1.4 2004/01/18 15:10:37 gustavoz Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc sparc ~alpha hppa ~amd64"
IUSE=""

DEPEND=">=gnome-base/gnome-vfs-2"

BUILD_GST_PLUGINS="gnome_vfs"
