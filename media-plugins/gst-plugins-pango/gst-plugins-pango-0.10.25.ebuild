# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.25.ebuild,v 1.6 2010/06/24 16:49:42 jer Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

# >=pango-1.15.4 to ensure vertical writing support
RDEPEND=">=x11-libs/pango-1.16"
DEPEND="${RDEPEND}"
