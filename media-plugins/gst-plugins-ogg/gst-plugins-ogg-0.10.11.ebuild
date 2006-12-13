# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.11.ebuild,v 1.1 2006/12/13 22:50:21 zaheerm Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~x86"
IUSE=""

RDEPEND=">=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.11"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
