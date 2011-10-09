# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-0.10.18.ebuild,v 1.5 2011/10/09 16:36:29 armin76 Exp $

EAPI=1

# Used for runtime detection of MMX/3dNow/MMXEXT and telling liba52dec
GST_ORC=yes

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/a52dec-0.7.3
	>=media-libs/gst-plugins-base-0.10.26
	>=media-libs/gstreamer-0.10.26"
DEPEND="${RDEPEND}"
