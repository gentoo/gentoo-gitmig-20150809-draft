# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.29.ebuild,v 1.3 2010/07/27 17:27:46 pacho Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16"
DEPEND="${RDEPEND}"
