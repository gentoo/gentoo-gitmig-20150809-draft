# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.18.ebuild,v 1.5 2010/08/01 20:31:06 klausman Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}"
