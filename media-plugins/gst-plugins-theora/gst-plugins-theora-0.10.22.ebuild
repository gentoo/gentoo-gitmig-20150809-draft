# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.22.ebuild,v 1.2 2009/05/03 17:37:08 klausman Exp $

inherit gst-plugins-base

KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/libtheora-1.0_beta1
	media-libs/libogg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
