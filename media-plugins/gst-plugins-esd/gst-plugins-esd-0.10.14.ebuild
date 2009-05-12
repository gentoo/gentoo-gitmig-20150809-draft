# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.14.ebuild,v 1.3 2009/05/12 20:40:52 fauli Exp $

inherit gst-plugins-good

KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
