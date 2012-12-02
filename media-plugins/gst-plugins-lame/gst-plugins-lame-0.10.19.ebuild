# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.19.ebuild,v 1.1 2012/12/02 17:55:33 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-sound/lame-3.95"
DEPEND="${RDEPEND}"
