# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.10.29.ebuild,v 1.2 2010/07/12 20:05:52 jer Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gnome_vfs"
