# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.6.3.ebuild,v 1.7 2003/10/18 22:54:00 brad_mssw Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc ~sparc alpha amd64"

IUSE=""
DEPEND=">=gnome-base/gnome-vfs-2"

BUILD_GST_PLUGINS="gnome_vfs"
