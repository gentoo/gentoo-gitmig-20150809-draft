# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-0.10.19.ebuild,v 1.1 2012/12/02 17:57:54 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.10"
DEPEND="${RDEPEND}"
