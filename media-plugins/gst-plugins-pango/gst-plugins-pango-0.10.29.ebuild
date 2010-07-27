# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.29.ebuild,v 1.3 2010/07/27 17:31:01 pacho Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/pango-1.16"
DEPEND="${RDEPEND}"
