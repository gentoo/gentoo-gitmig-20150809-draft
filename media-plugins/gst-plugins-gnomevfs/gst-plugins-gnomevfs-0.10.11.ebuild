# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gnomevfs/gst-plugins-gnomevfs-0.10.11.ebuild,v 1.1 2006/12/07 13:38:05 zaheerm Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.11
	>=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gnome_vfs"
