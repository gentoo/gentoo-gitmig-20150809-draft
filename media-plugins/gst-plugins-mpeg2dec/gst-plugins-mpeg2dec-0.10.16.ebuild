# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mpeg2dec/gst-plugins-mpeg2dec-0.10.16.ebuild,v 1.1 2010/12/27 13:08:50 leio Exp $

inherit gst-plugins-ugly

DESCRIPTION="Libmpeg2 based decoder plug-in for gstreamer"
KEYWORDS="~alpha ~amd64 ~amd64-linux ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.26
	>=media-libs/gstreamer-0.10.26
	>=media-libs/libmpeg2-0.4"
DEPEND="${RDEPEND}"
