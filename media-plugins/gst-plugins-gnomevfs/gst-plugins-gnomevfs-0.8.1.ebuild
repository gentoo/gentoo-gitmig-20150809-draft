# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.8.1.ebuild,v 1.7 2005/03/10 02:04:23 gustavoz Exp $

inherit gst-plugins

KEYWORDS="x86 ppc ~sparc ~alpha hppa ~amd64 arm ia64 ~mips"
IUSE=""

DEPEND=">=gnome-base/gnome-vfs-2"

GST_PLUGINS_BUILD="gnome_vfs"
