# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.23.ebuild,v 1.5 2011/01/06 17:13:46 armin76 Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
